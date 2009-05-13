From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 12:24:30 +0300
Message-ID: <4A0A91CE.3080905@gmail.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com> <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com> <alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de> <200905130724.44634.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Ahl-0006V6-RP
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbZEMJYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 05:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757172AbZEMJYk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:24:40 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47332 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbZEMJYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 05:24:39 -0400
Received: by ewy24 with SMTP id 24so625287ewy.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=q8uhFsXOBGBe/k8W/wcZMw3B6y7/2C7kTVwFGxHr4qA=;
        b=nSW/k7jQ9jBOdrTeFzk7oL4/3E73B7lbyzBlDDcv/j/BVhzapbQB0Bxu4tGiytFqqx
         rsBZoAAOd0Qr5uV2DnfEMCPAPGUw+yJ35fRsLb1DGRnFLVThgoj36Z31atZzuhwaGDVb
         pzj0JXNHFDZtD9xlEWDN1SVdczFN4HsEfmzA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cp0pmy3MWPpI81GV0SLLksQRZZrQdSr6WV0JH5ybhRoczac6D98Tx0e56ySrM5f+rl
         2frbgn0BkXRLgQpX4D9hfA29uFL6nrGtd7BcAXT7nt2oLmtykTmHUwdHcatNm0/uPvnG
         Lx2rjcEI2sSIxvn6TcbtjVYhuwv7ksIC5rSns=
Received: by 10.210.86.10 with SMTP id j10mr8082553ebb.70.1242206679020;
        Wed, 13 May 2009 02:24:39 -0700 (PDT)
Received: from ?10.0.0.2? ([88.195.117.100])
        by mx.google.com with ESMTPS id 7sm2160858eyg.57.2009.05.13.02.24.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 02:24:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200905130724.44634.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119013>

Robin Rosenberg wrote on 13.5.2009 8:24:
> If the conclusion is that this is a way forward, then I
> could start working on a completely new set of much cleaner patches.,

That would be great!

I see that in those early patches you took the approach of converting 
the filenames from the local encoding to UTF-8 at the outer edges of 
Git. That obviously was the easiest way to make the changes with minimal 
changes to Git.

I've been thinking about a bit more extensive approach, which should 
serve the interest of all stakeholders:


Now the tree object contains the following information for each file: 
filename, mode, sha1. To that would be added one more string: filename 
encoding. Unless the encoding is specified (such as in old commits 
before the encoding information was added), the default encoding is 
"binary", which is the same as how Git works now (it thinks filenames as 
series of bytes, ignoring their encoding completely).

When a file is added/committed, the following things will happen:

1. Git finds out what is the filename encoding used by the system. Git 
will try to detect it automatically from the environment, and the 
autodetected value can be overridden by setting a config variable 
"i18n.localFilenameEncoding". If autodetection fails, it will default to 
"binary".

2. Git reads the config variable "i18n.commitFilenameEncoding". If 
localFilenameEncoding equals commitFilenameEncoding, or if either of 
them is "binary", go to step 3A. Otherwise go to step 3B.

3A. Git saves the filename together with the local filename encoding. 
The bytes of the filename are not changed when it is stored in the 
repository (the same as now).

3B. Git converts the filename from localFilenameEncoding to 
commitFilenameEncoding. (The commitFilenameEncoding may also specify a 
normalized form for UTF-8, for example "UTF-8 NFC". This is needed for 
Mac OS X.) Then Git saves the filename together with the commit filename 
encoding.


When a file is checked out, the following things will happen:

1. Git reads the actual filename encoding from the repository. If it is 
not specified, "binary" will be assumed.

2. Git detects the local filename encoding, the same was as before. If 
the actual filename encoding equals the local filename encoding, or if 
either of them is "binary", go to step 3A. Otherwise go to step 3B.

3A. Git creates the file using the same bytes as filename as what is 
stored in the repository. This is the same as how Git works now.

3B. Git converts the filename from the actual filename encoding to the 
local filename encoding, and creates the file using the encoding of the 
local platform.


This should fit in with Git's philosophy of not modifying the user's 
data without the user's permission. The data will always be stored 
unchanged into the repository, unless the user specifies 
"i18n.commitFilenameEncoding". The conversions are by default done only 
on checkout. Git will try to serve the needs of the user as well as it 
can by detecting the local filename encoding, but if the user so 
desires, he can disable the conversions by specifying 
"i18n.localFilenameEncoding" as "binary", in which case Git will work 
the same way as it does today.


I was browsing Git's code, and it seems that the encoding information 
would need to be added to struct name_entry in tree-walk.h. A quick 
search reveals that name_entry is used in 15 files, out of which only 4 
files use it more than once. It would probably make sense to create a 
new datatype for the filename, for example "struct encoded_path { const 
char *path; const char *encoding; }", and then provide functions for 
accessing the filename with the right encoding (commit or local).

I might even myself be able to make that change, because Git is not 
legacy software (it has tests) and the needed changes seem quite local. 
I would just need a way to detect the encodings (at first it could rely 
on manually set config variables) and have a library for doing the 
encoding conversions.

One big question is, that will this change require a change to the 
repository format? Will it be possible to add the encoding field to the 
tree object, without breaking compatibility with older Git clients? If 
compatibility needs to be broken, how it can be done in a controlled 
fashion?

-- 
Esko Luontola
www.orfjackal.net
