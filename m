From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Mon,  5 Aug 2013 22:12:21 +0200
Message-ID: <1375733541-9099-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 22:12:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6R92-00044l-At
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 22:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab3HEUMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 16:12:40 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54237 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab3HEUMj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 16:12:39 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so1754478wgh.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ov3QVXgF0KJ78/yaOk4GNNOKzMr/4gC61eaDye7jO3s=;
        b=IvuJAA/wvAk1P9y7QLpCl8Uovtc6nQEZWrl0Lu5jhsDn9KNEItyUwq/mVHhhBRv3h7
         bszhCagJuqF6P4S6t2R00F6iKciKKOzjdYt3JCEETY4kk4mVWSQc5+JyDaXq1FHbE0dp
         KE5Ry+AjRd0JMv9h5k+5EL1PRl++/nvofGsiBqvYGxcYUyiOlfFEy7bkZXw0sPeAG9Yz
         xMn6XTn2UHiCkAe0UWelCkEXSfhNMMgiieHAaAtpaF7Qb3bYTYfksPIPCrUIG5H4qWCx
         mq8u854FMvf2YGydb7jdzzcaD+PeJqQ3sJGnYnLIAEzy5jru1ILWxXFHU6UasSahFCC0
         KnVw==
X-Received: by 10.194.11.67 with SMTP id o3mr14713526wjb.0.1375733558271;
        Mon, 05 Aug 2013 13:12:38 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id dt17sm1147401wic.1.2013.08.05.13.12.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 13:12:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231699>

The current code fixes the path to make it absolute when cloning, but
doesn't consider tilde expansion, so that scenario fails throwing an
exception because /home/myuser/~/my/repository doesn't exists:

    $ git clone hg::~/my/repository && cd repository && git fetch

Fix that by using python os.path.expanduser method.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 02404dc..4bbd296 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -1137,7 +1137,7 @@ def fix_path(alias, repo, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
     if url.scheme != 'file' or os.path.isabs(url.path):
         return
-    abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
+    abs_url = os.path.abspath(os.path.expanduser(orig_url))
     cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % abs_url]
     subprocess.call(cmd)
 
-- 
1.7.9.5
