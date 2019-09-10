Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B7E1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436947AbfIJQup (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 12:50:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:51508 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436944AbfIJQuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 12:50:44 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46SWHk3ryCz5tlD;
        Tue, 10 Sep 2019 18:50:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A5EE61D27;
        Tue, 10 Sep 2019 18:50:41 +0200 (CEST)
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, me@yadavpratyush.com,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <01e3c41d-af69-f9b3-31e6-12192e566f92@kdbg.org>
Date:   Tue, 10 Sep 2019 18:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.19 um 22:10 schrieb Bert Wesarg:
> The commit message widget does not wrap the next and has a configurable
> fixed width to avoid creating too wide commit messages. Though this was
> only enforced in the GUI. Now we also check the commit message at commit
> time for long lines and ask the author for confirmation if it exceeds the
> configured line length.
> 
> Needs Tcl 8.6 because of `lmap`.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh     |  4 ++--
>  lib/commit.tcl | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..a491085 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -31,8 +31,8 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
>  ##
>  ## Tcl/Tk sanity check
>  
> -if {[catch {package require Tcl 8.4} err]
> - || [catch {package require Tk  8.4} err]
> +if {[catch {package require Tcl 8.6} err]
> + || [catch {package require Tk  8.6} err]
>  } {
>  	catch {wm withdraw .}
>  	tk_messageBox \
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index 83620b7..fa9760b 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -215,6 +215,16 @@ A good commit message has the following format:
>  		unlock_index
>  		return
>  	}
> +	if {[tcl::mathfunc::max {*}[lmap x [split $msg "\n"] {string length $x}]] >= $repo_config(gui.commitmsgwidth) \

This has an off-by-one error: When I fill the edit box to the limit, but
not beyond it, I get the warning popup. I guess this should be '>', not
'>='.

> +	    && [ask_popup "Commit message contains lines longer than $repo_config(gui.commitmsgwidth) characters.
> +
> +You may change this limit in the options.
> +
> +Continue to commit?
> +"] ne yes} {
> +		unlock_index
> +		return
> +	}
>  
>  	# -- Build the message file.
>  	#
> 

-- Hannes
