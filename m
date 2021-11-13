Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26257C4332F
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23C161179
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhKMIHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 03:07:34 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36841 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMIHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 03:07:32 -0500
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5675620003;
        Sat, 13 Nov 2021 08:04:37 +0000 (UTC)
Date:   Sat, 13 Nov 2021 13:34:35 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com
Subject: Re: [RFC PATCH 4/4] track oid_size to allow for checks that are hash
 agnostic
Message-ID: <20211113080435.54vs6ihljtkwcpe4@yadavpratyush.com>
References: <20211011121757.627-1-carenas@gmail.com>
 <20211011121757.627-5-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011121757.627-5-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/21 05:17AM, Carlo Marcelo Arenas Belón wrote:
> This allows commit to work.

Please explain _why_ it allows commit to work.

> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  git-gui.sh     | 5 +++--
>  lib/commit.tcl | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index c0dc8ce..1646124 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1821,10 +1821,11 @@ proc short_path {path} {
>  
>  set next_icon_id 0
>  if { [get_config extensions.objectformat] eq "sha256" } {
> -	set null_oid [string repeat 0 64]
> +	set oid_size 64
>  } else {
> -	set null_oid [string repeat 0 40]
> +	set oid_size 40
>  }
> +set null_oid [string repeat 0 $oid_size]
>  
>  proc merge_state {path new_state {head_info {}} {index_info {}}} {
>  	global file_states next_icon_id null_oid
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index 11379f8..1306e8d 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -337,6 +337,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>  	global file_states selected_paths rescan_active
>  	global repo_config
>  	global env
> +	global oid_size
>  
>  	gets $fd_wt tree_id
>  	if {[catch {close $fd_wt} err]} {
> @@ -356,7 +357,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>  		close $fd_ot
>  
>  		if {[string equal -length 5 {tree } $old_tree]
> -			&& [string length $old_tree] == 45} {
> +			&& [string length $old_tree] == 5 + oid_size} {
                                           ^ missing '$'

I think you forgot to test this one ;-)

>  			set old_tree [string range $old_tree 5 end]
>  		} else {
>  			error [mc "Commit %s appears to be corrupt" $PARENT]
> -- 
> 2.33.0.1081.g099423f5b7
> 

-- 
Regards,
Pratyush Yadav
