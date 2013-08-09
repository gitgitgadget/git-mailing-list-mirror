From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri,  9 Aug 2013 19:13:07 +0200
Message-ID: <1376068387-28510-1-git-send-email-apelisse@gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:13:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qFm-00068T-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab3HIRN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:13:26 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:51041 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3HIRNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:13:25 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so728762wes.38
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R64qIlHdmjiRvy3evB25f6Cr0XgqXmwXv2/5rkZRs6s=;
        b=h6v2Fp2+9Ya92c7miKo4+EFOWnltWNgMF05naMZjad7fcrKsbPQ3UsG+17zcUuqsEp
         Rd07eXSOgRozIY1xBEoXQ6DUCTmFLGCJKqdMhPJqLEq7sjQ8fcqTDt1j99LYDmkzvbLl
         pIzKhf+/ohBQ/BIGOeGWJszdzMEN9u2RN3BW3TzyiXy682Tmov9YQaIVWQ1jdu+qD1s6
         AGPfdLphCSFl6Rn103/7HolEuVqXMzH1qLprOm93IhQtmqszA4hkMomurkHsU4DFYP3/
         +4bLbQkW/taXf14V2SOvFWDeqN0LoAqYaazYSIABWEpToGMnXK3gqlf6kiCmwG7E6WAQ
         ij5g==
X-Received: by 10.180.79.161 with SMTP id k1mr819434wix.36.1376068404512;
        Fri, 09 Aug 2013 10:13:24 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id hb2sm1850615wib.0.2013.08.09.10.13.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 10:13:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231998>

The current code fixes the path to make it absolute when cloning, but
doesn't consider tilde expansion, so that scenario fails throwing an
exception because /home/myuser/~/my/repository doesn't exists:

    $ git clone hg::~/my/repository && cd repository && git fetch

Expand the tilde when checking if the path is absolute, so that we don't
fix a path that doesn't need to be.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
On Mon, Aug 5, 2013 at 10:30 PM, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Shouldn't that be the job of the shell? (s/~/$HOME/)

I'm not sure what you mean here. Does it mean that I should stop cloning using "~" ?
I also send this patch as I think it makes more sense to keep the ~ in the path, but just make
sure we don't build invalid absolute path.

By the way, I don't exactly understand why:

    abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)

is done right after instead of:

    abs_url = os.path.abspath(orig_url)

Cheers,
Antoine

 contrib/remote-helpers/git-remote-hg |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 1897327..861c498 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -1135,7 +1135,7 @@ def do_option(parser):

 def fix_path(alias, repo, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
-    if url.scheme != 'file' or os.path.isabs(url.path):
+    if url.scheme != 'file' or os.path.isabs(os.path.expanduser(url.path)):
         return
     abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
     cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % abs_url]
--
1.7.9.5
