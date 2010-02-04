From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Wed, 3 Feb 2010 18:07:56 -0800
Message-ID: <20100204020756.GP14799@spearce.org>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> <20100129183705.GB22101@spearce.org> <7vockc45ut.fsf@alter.siamese.dyndns.org> <7vmxzw15dt.fsf@alter.siamese.dyndns.org> <7v3a1oyrkp.fsf@alter.siamese.dyndns.org> <20100201152826.GE8916@spearce.org> <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:08:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncr8Z-00013P-GH
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab0BDCIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:08:00 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:38046 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab0BDCH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:07:59 -0500
Received: by iwn39 with SMTP id 39so2423306iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 18:07:58 -0800 (PST)
Received: by 10.231.182.132 with SMTP id cc4mr727293ibb.86.1265249278563;
        Wed, 03 Feb 2010 18:07:58 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 20sm6042115iwn.5.2010.02.03.18.07.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 18:07:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138932>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> Well, well, well....
> 
> The documentation says this is counted in bytes, but somehow neither of us
> found the above " * 1024 * 1024" suspicious.
> 
> Shouldn't it be at least like this?  It would probably be a good idea to
> use git_parse_ulong() or somesuch while we are at it.
> 
>  fast-import.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index ca21082..ea1ac0f 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2800,7 +2800,7 @@ static int parse_one_option(const char *option)
>  	if (!prefixcmp(option, "max-pack-size=")) {
>  		option_max_pack_size(option + 14);
>  	} else if (!prefixcmp(option, "big-file-threshold=")) {
> -		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
> +		big_file_threshold = strtoumax(option + 19, NULL, 0);

In my v3 patch I thought I replaced this code with:

+               else if (!prefixcmp(a, "--big-file-threshold=")) {
+                       unsigned long v;
+                       if (!git_parse_ulong(a + 21, &v))
+                               usage(fast_import_usage);
+                       big_file_threshold = v;

So we relied on git_parse_ulong to handle unit suffixes as well.

-- 
Shawn.
