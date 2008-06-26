From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [Bug?] git submodule add doesn't respect core.autocrlf
Date: Thu, 26 Jun 2008 10:40:16 +0200
Message-ID: <8c5c35580806260140g3133817ele6683d56699a9199@mail.gmail.com>
References: <g3vaaq$pm1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBn2r-0000Fj-56
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYFZIkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbYFZIkb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:40:31 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:29996 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYFZIka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:40:30 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1272283ywe.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0LqCVX4mWDHVCT0i7WTa/kvbhObilOALhwIRMaMnk5s=;
        b=P/f9Ltlmvpl6hDuFHQRNUZqeSpa/ReovOgGEdpkVNECTWbfZRjW85R0X3D5TXP7n46
         v9Ccen0MUVobrf/gGvpavVRsdqzJ5WFEQjA+mEoqlyJlv+3Yuh4cnjiAQYjuf1Vhkc9U
         SLCbrfOiTg7kHXjawnBPC2lk2IcXOWqPEp2jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J/E5yQRuUT0RwRcqK1HPRXy4/KXTfrp8kLUtK3b8DNRhikPXyQlwIt5G+CpLlvox89
         BKEk//495ylWe0Rz9Kc/NBV5H+nuOvJAI8PZyhaGjR1GbX5o9KzOB0jJXyqwNAB/40f1
         F7zkqGgB9N+X9w/WokuACH5fCRdZZF01b1V10=
Received: by 10.150.151.11 with SMTP id y11mr1435400ybd.158.1214469617078;
        Thu, 26 Jun 2008 01:40:17 -0700 (PDT)
Received: by 10.151.149.15 with HTTP; Thu, 26 Jun 2008 01:40:16 -0700 (PDT)
In-Reply-To: <g3vaaq$pm1$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86417>

On Thu, Jun 26, 2008 at 7:43 AM, Edward Z. Yang
<edwardzyang@thewritingpot.com> wrote:
> mkdir test
> cd test
> git init
> git config core.safecrlf true
> git config core.autocrlf true

You can work around the problem by issuing the following commands at this point:

echo ".gitattributes -crlf" >> .gitattributes
echo ".gitmodules -crlf" >> .gitattributes
git add .gitattributes

> git submodule add http://repo.or.cz/w/htmlpurifier.git htmlpurifier
>
> You get: "fatal: LF would be replaced by CRLF in .gitmodules" and inspecting .gitmodules reveals that it uses LF, instead of CRLF.
>
> Can anyone reproduce? Thanks.

Yes, this also fails on linux (without the workaround).

To fix it "properly", git-config needs to choose between lf and crlf
(git-submodule uses git-config to write .gitmodules). But this depends
on
* whether the 'configfile' is (or will be!) tracked by git (e.g. .gitmodules)
* whether a crlf-attribute is specified for the 'configfile'
* the setting of core.autocrlf

A simpler solution might be to treat .gitmodules specially in
check_safe_crlf(), maybe something like this (possibly wrapped by
gmail...):

diff --git a/convert.c b/convert.c
index 1c66844..254a99b 100644
--- a/convert.c
+++ b/convert.c
@@ -91,6 +91,15 @@ static void check_safe_crlf(const char *path, int action,
        if (!checksafe)
                return;

+       /* Dirty hack: git-submodule uses git-config to update .gitmodules, and
+        * there's no reasonable way for git-config to know if the user prefers
+        * crlf or lf line endings for this file. And since it really doesn't
+        * matter, lets just ignore that the line endings might be modified by
+        * a later checkout.
+        */
+       if (!strcmp(path, ".gitmodules"))
+               return;
+
        if (action == CRLF_INPUT || auto_crlf <= 0) {
                /*
                 * CRLFs would not be restored by checkout:

--
larsh
