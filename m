From: David Barr <david.barr@cordelta.com>
Subject: Re: Status of the svn remote helper project (Nov 2010, #2)
Date: Mon, 22 Nov 2010 13:06:44 +1100
Organization: Cordelta Pty Ltd
Message-ID: <201011221306.45096.david.barr@cordelta.com>
References: <20101107112129.GA30042@burratino> <BB713021-7826-4E9E-8576-7D1704BF517C@cordelta.com> <20101121230613.GA24397@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 03:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKLoQ-0002Jf-MU
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 03:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab0KVCHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 21:07:15 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36545 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab0KVCHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 21:07:14 -0500
Received: by gwb20 with SMTP id 20so1040141gwb.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 18:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=9CfIbslTTywmQlkjxBV4HYnZ0DOUXekO5IADsYxe5TA=;
        b=TTAZXhbsZgrniqx27NqI5Pi1re+kfjgDkPHcrBUx99gMFt3u0QQPHhrvIrb1pllNEN
         N0Fwwg01FatJteM68+HczFAt0JcvSXk+opUaaAH1wksad4RyAJ6kld1uHbFAjiwL2fEU
         6tn8dwoTnuIfVdv9VxPBHk9pCmzGrjxnG6v7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=Kg0G9e7p3XdSKfbtLW4S4BXkayZKHYyMG6YRkuh4c1QIELtIPzIW8nrulTsXZMLqjP
         Ebdssq62o+wsg+cx+xyIq8k/azhoZZneOyhRdRHnjwMOHU3jGDDeFd46qzBTEboaFJ+V
         Eb4OL8ghRgUcDQUeX1x76MKHB57zU7XkT+kxs=
Received: by 10.150.206.6 with SMTP id d6mr3348652ybg.242.1290391633608;
        Sun, 21 Nov 2010 18:07:13 -0800 (PST)
Received: from dba.localnet ([119.15.97.146])
        by mx.google.com with ESMTPS id p20sm1631713ybe.5.2010.11.21.18.07.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Nov 2010 18:07:12 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <20101121230613.GA24397@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161878>

Hi,

> >> A delta in r36 of <http://svn.apache.org/repos/asf> does not apply
> >> with this brand of svn-fe.
> >
> > That's odd, I was able to import up to r354 before receiving:
> > fatal: missing newline after cat-blob response
> 
> Apparently sometimes deltas use the whole preimage and sometimes they
> don't.
> 
> Here's a fix (still needs a simple reproduction script).

I'm testing this path along with the following changes.
The first just removes a compile-time warning.
The second fixes a memory leak.
Sorry, my send-email-fu is not up to scratch.

Signed-off-by: David Barr <david.barr@cordelta.com>
---
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 02456cf..a95a5c9 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -127,7 +127,6 @@ static long apply_delta(uint32_t mark, off_t len, struct 
line_buffer *input,
                die("cannot open temporary file for blob retrieval");
        if (old_mark) {
                const char *response;
-               off_t dummy;
                printf("cat-blob :%"PRIu32"\n", old_mark);
                fflush(stdout);
                response = get_response_line();
@@ -147,6 +146,7 @@ static long apply_delta(uint32_t mark, off_t len, struct 
line_buffer *input,
        ret = buffer_tmpfile_prepare_to_read(&postimage);
        if (ret < 0)
                die("cannot read temporary file for blob retrieval");
+       strbuf_release(&preimage.buf);
        return ret;
 }
 
