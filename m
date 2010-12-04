From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Fri, 3 Dec 2010 20:35:15 -0600
Message-ID: <20101204023515.GA18735@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
 <20101128194501.GD19998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 03:35:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POhyM-0004gU-J6
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 03:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0LDCfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 21:35:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44803 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab0LDCfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 21:35:32 -0500
Received: by gyb11 with SMTP id 11so5139563gyb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 18:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K2ugWlaCcSul5FYc2a1Lm14aNiREdYCe/KdIVDyphZ8=;
        b=ZYsY+I5rF3Bzfaisdzz9SYnIKH3nWhKJSev7j6WlY1ct+mOGtKZ1wbT5MqOYhmtMMf
         z9qNl4gB8scNXGZCFpEVNkwZ0iBfOnjsqH4cdRCaVuk/zFt19Vd5rA1fmPP+k5rB268s
         /QSN1Hec5Pmy4HqbslmqUdm10krRzjQUkEu+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RzFJeobsCYla+wbaeCVdMtANzPlJcEO5C8cGevGRDFZXaVNV2BtTQmfLQ7qUc/o4uI
         3dITfEKOXFpHLZsgQltz7hepUcOCBf9a/kmwLQ+rJ0fsiCNot3mtYLxJWuMOWtzliNEe
         t0WMBBcpsXJjtzqNabutX17iNJRAISr5axBg8=
Received: by 10.151.79.11 with SMTP id g11mr4960797ybl.196.1291430131726;
        Fri, 03 Dec 2010 18:35:31 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id v39sm21717yba.19.2010.12.03.18.35.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 18:35:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128194501.GD19998@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162882>

Jonathan Nieder wrote:
>                                                              The value
> for cat-blob-fd cannot be specified in the stream because that would
> be a layering violation: the decision of where to direct a stream has
> to be made when fast-import is started anyway, so we might as well
> make the stream format is independent of that detail.

Ungrammatical.  I think I meant:

 There is no POSIX facility to open a file descriptor from outside
 after a process has already started; therefore, the frontend has to
 prepare a file descriptor for writing blobs before executing
 git fast-import.  The --cat-blob-fd command line option indicates
 which file descriptor that is, defaulting to 1.

 It does not make sense to wait until the stream starts to specify
 which fd so it is not allowed, avoiding a potential layering
 violation.  Other fast-import backends might provide other ways to
 specify where the blob stream should be written.

> +++ b/fast-import.c
> @@ -2824,6 +2910,8 @@ static int parse_one_feature(const char *feature, int from_stream)
>  		option_import_marks(feature + 13, from_stream);
>  	} else if (!prefixcmp(feature, "export-marks=")) {
>  		option_export_marks(feature + 13);
> +	} else if (!strcmp(feature, "cat-blob")) {
> +		; /* Don't die - this feature is supported */

Implies support for a "--cat-blob" command line option
that checks for cat-blob support.  Is this wanted?

(If so, it should be documented.  If not, the condition should be 
"from_stream && !strcmp(...)".)

> @@ -2918,6 +3006,11 @@ static void parse_argv(void)
>  		if (parse_one_feature(a + 2, 0))
>  			continue;
>  
> +		if (!prefixcmp(a + 2, "cat-blob-fd=")) {
> +			option_cat_blob_fd(a + 2 + strlen("cat-blob-fd="));
> +			continue;
> +		}
> +

Would be simpler and more explicit to put in parse_one_feature:

	} else if (!from_stream && !prefixcmp(feature, "cat-blob-fd=")) {

Sorry this is taking so long to get right. :-/
Jonathan
