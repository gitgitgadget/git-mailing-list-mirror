From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] check-attr: move to the top of working tree when in
 non-bare repository
Date: Thu, 6 Feb 2014 11:53:10 -0800
Message-ID: <20140206195310.GV30398@google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
 <1391712033-9443-1-git-send-email-gitster@pobox.com>
 <1391712033-9443-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:53:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBV0h-0003lj-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbaBFTxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 14:53:14 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:37782 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082AbaBFTxO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:53:14 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so2203497pbc.4
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 11:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HTcozMEEQ479Hk5y9do8LOBdA/bjRuzC7vwN7LlZnjc=;
        b=fCIFsR3sAzYCGNvrbqkhdO5q8+h8wWt5F3An5kvSfZMkCHbv0lCEo7M+MKcFacXLyz
         kiuKJ2PDplyZ5Kfk+v2STsfRFAp0Se1ZCh9MneevtxIPtCwQWRph87YYHJW3CcxwYP4T
         yFSfIXCMVyUGk+39sr3jdpDg79OZyeiIguf8NOSKOEvvHuCi7f4uIfmEzezV3dgy0CIM
         YG5PIQXFpUQkV6BDlpfB6sJCzPKMUQOFjZF9iaPtPyHWFLgG6jqL5YimzZYbmbn3PA8y
         lI646k8dX6uHTObS+feu0/TvWoe5JS28tFsO4gwkYbkyEp18cP8QI6dF9EoYo4MMm7Jp
         44SA==
X-Received: by 10.68.20.1 with SMTP id j1mr14723693pbe.148.1391716393746;
        Thu, 06 Feb 2014 11:53:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rb6sm6168975pbb.41.2014.02.06.11.53.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 11:53:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391712033-9443-2-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241721>

Hi,

Junio C Hamano wrote:

> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -94,6 +94,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
>  	struct git_attr_check *check;
>  	int cnt, i, doubledash, filei;
>  
> +	if (!is_bare_repository())
> +		setup_work_tree();

Hm.  Shouldn't check-attr error out when run without a worktree and
without --cached?

That would mean something like

diff --git i/builtin/check-attr.c w/builtin/check-attr.c
index e9af7b2..c34b6ee 100644
--- i/builtin/check-attr.c
+++ w/builtin/check-attr.c
@@ -107,6 +107,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
+	if (!cached_attrs)
+		setup_work_tree();
+
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
