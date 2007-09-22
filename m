From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: C++ *for Git*
Date: Sat, 22 Sep 2007 03:42:00 -0700
Message-ID: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 12:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ2RP-00080v-Hv
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 12:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbXIVKmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 06:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXIVKmH
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 06:42:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:65401 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbXIVKmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 06:42:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1296426wah
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        bh=KIlYOyZF2D0/bkWI5I9UnkE1gCcQNUUsNWUmKmMEAas=;
        b=QZV9bZP6IF8KVNL0dE8aahn5VBMSgtNHc70iRtHog+uWkO7bdvUGTgG/sV1u69o3O9aWZJZ4kzMWvae/gkYhIQ6KE7rjMdj9BUbzXZSBUjh1GNwYx8pqdfqoxOGUVp+/uSfNpYSsOiSruIqc3yHlGyD4ZDh0SgVxBadnfZRIZ4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=NjU+2lLmQJgOT6eP58ajM2h+sT4h+g6OTCl+6jiTHuyCt41CxZgFp8kiaXNBi9VExhfmX7iyUZIQthiL77Bs3AkHM09kKb15YwiM4mZJiSlBvQyIvqVHVKfI7I+PB4RFOM9RE81VtrYm7w9bP3JsOZ7vTe2vzssHfz7tGBSMUG8=
Received: by 10.114.157.1 with SMTP id f1mr518584wae.1190457722875;
        Sat, 22 Sep 2007 03:42:02 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id c20sm4224013rvf.2007.09.22.03.42.01
        (version=SSLv3 cipher=OTHER);
        Sat, 22 Sep 2007 03:42:01 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58929>

We've had this theoretical (and IMHO pointless) discussion C vs. C++ *in 
general*.
In no way I want to restart it. But *very specifically*, and *for Git*:
We already have strbuf "class" to do string/buffer manipulations.
Kudos to Pierre Habouzit for doing the refactoring work!
Now, what I fail to understand is how this:

static void write_global_extended_header(const unsigned char *sha1)
{
    struct strbuf ext_header;

    strbuf_init(&ext_header, 0);
    strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
    write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
    strbuf_release(&ext_header);
}

is better than this:

static void write_global_extended_header(const unsigned char *sha1)
{
    strbuf ext_header;

    ext_header.append_ext_header("comment", sha1_to_hex(sha1), 40);
    write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
}

?
Note, there is no Boost/multiple inheritance/template 
metaprogramming/std::string/whatever-else-scares-you-in-C++ in the second 
piece of code.
Just a very straight-forward usage of only 3 C++ features:
1. Constructors
2. Destructors
3. Better syntax (ext_header.append_ext_header vs. 
strbuf_append_ext_header(&ext_header, )

The generated code will be exactly the same.
Yet the source code becomes more readable and MUCH less error prone. How is 
this not a win?

One (sensible) argument that I've heard in the previous discussion was: you 
let a little bit of C++ in and then it gets more and more complex and the 
code quality decreases.
This problem is solved by having "quality gates".
Again, *for Git* these quality gates already exist: only few people have 
"commit access".
If/when somebody tries to be too fancy, what stops Junio from replying "we 
don't use Library-X/C++-feature-Y in Git, please change your code and 
resubmit" and throwing that fix away? Nothing.

- Dmitry
