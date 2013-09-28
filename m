From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Sun, 29 Sep 2013 06:17:16 +0900
Message-ID: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>,
	msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBDD7TRGTWYIBB2UOTWJAKGQETOBFBAY@googlegroups.com Sat Sep 28 23:17:35 2013
Return-path: <msysgit+bncBDD7TRGTWYIBB2UOTWJAKGQETOBFBAY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f190.google.com ([209.85.213.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBB2UOTWJAKGQETOBFBAY@googlegroups.com>)
	id 1VQ1tL-0007Ru-NB
	for gcvm-msysgit@m.gmane.org; Sat, 28 Sep 2013 23:17:31 +0200
Received: by mail-ye0-f190.google.com with SMTP id m13sf844854yen.27
        for <gcvm-msysgit@m.gmane.org>; Sat, 28 Sep 2013 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=LFX8zpncn/dFw/g2nDhaXUX5rEOIzRRFEkLVQLmgbf4=;
        b=jw2q6MqEa/e1vch5ZNhWk/B0OmKCaAp36RN8kRExudRTCFVwNwtZX6QLJOcHafF4zO
         sxtn/B3VJkj70ZralQS2Hz+FTxByVge/3hmvfEhYi5bZcm5P6BJgwsoYz5sTIe7pIYTc
         5ihgpqtj9blM2O+xbDOSw/duZzJyViqC+fHELeT2sTCY6qnvuuNXoLkv7my+MNbYbZXZ
         cSEybZIehdiKvBRN3BuiaYli986V+p6uOgkAsSdpHkhhk1qidwFbjY6mbl/c2HTZ7G2K
         sOqyZw6F0uu15xkXbQd13wyNo0Rp9SOD3QXi7MgT4fMEP9OEgd2zPI3lSNKSJOsZTR72
         qCzA==
X-Received: by 10.50.110.6 with SMTP id hw6mr285752igb.13.1380403050861;
        Sat, 28 Sep 2013 14:17:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.136.170 with SMTP id qb10ls998429igb.37.gmail; Sat, 28 Sep
 2013 14:17:30 -0700 (PDT)
X-Received: by 10.66.148.8 with SMTP id to8mr15984860pab.0.1380403050095;
        Sat, 28 Sep 2013 14:17:30 -0700 (PDT)
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com [2607:f8b0:400e:c02::22b])
        by gmr-mx.google.com with ESMTPS id dk16si2448336pac.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:17:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c02::22b as permitted sender) client-ip=2607:f8b0:400e:c02::22b;
Received: by mail-pd0-f171.google.com with SMTP id g10so4002484pdj.16
        for <msysgit@googlegroups.com>; Sat, 28 Sep 2013 14:17:30 -0700 (PDT)
X-Received: by 10.66.196.110 with SMTP id il14mr19187244pac.130.1380403049950;
        Sat, 28 Sep 2013 14:17:29 -0700 (PDT)
Received: from localhost.localdomain (p4168-ipbf905akatuka.ibaraki.ocn.ne.jp. [219.114.17.168])
        by mx.google.com with ESMTPSA id aq1sm16975709pbc.9.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:17:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c02::22b
 as permitted sender) smtp.mail=wnoguchi.0727@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235507>

fix: Git for Windows crashes when clone Japanese multibyte repository.

Reproduce condition:

- Japanese Base Encoding is Shift-JIS.
- It happens Japanese multibyte directory name and too-long directory path
- Linux(ex. Ubuntu 13.04 amd64) can clone normally.
- example repository is here:

git clone https://github.com/wnoguchi/mingw-checkout-crash.git

- The reproduce crash repository contains following file only.
  - following directory and file name is encoded for this commit log.
  - actually file name is decoded.]
  %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%=
E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3=
%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E6%9=
7%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%A=
A%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%=
E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5%E6=
%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%205-l=
ong-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%AA%A=
D%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
- only one commit.

Cause:

- convert_attrs() in convert.c: if (!ccheck[0].attr) but ccheck[0].attr alw=
ays not NULL.
  thus git_check_attr() in attr.c (check[i].attr->attr_nr) cause access vio=
lation.
- checkout_entry() in entry.c: static char path[PATH_MAX + 1]; declared.
  But its size is 261 on MinGW environment.
  This length is Windows full path limits. But for relative path is too sho=
rt.

This commit fixes:

- convert_attrs() in convert.c: initialize ccheck[0].attr with NULL.
- git-compat-util.h: redifine PATH_MAX value to 4096 when MinGW environment=
.

Signed-off-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
---
 convert.c         |  5 +++++
 git-compat-util.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/convert.c b/convert.c
index 11a95fc..5eaa206 100644
--- a/convert.c
+++ b/convert.c
@@ -724,6 +724,11 @@ static void convert_attrs(struct conv_attrs *ca, const=
 char *path)
 {
 	int i;
 	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
+=09
+	if (NUM_CONV_ATTRS !=3D 0) {
+		ccheck[0].attr =3D NULL;
+		ccheck[0].value =3D NULL;
+	}
=20
 	if (!ccheck[0].attr) {
 		for (i =3D 0; i < NUM_CONV_ATTRS; i++)
diff --git a/git-compat-util.h b/git-compat-util.h
index a31127f..ba02c69 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -237,6 +237,16 @@ extern char *gitbasename(char *);
 #ifndef PATH_MAX
 #define PATH_MAX 4096
 #endif
+#ifdef GIT_WINDOWS_NATIVE
+/* Git for Windows checkout PATH_MAX is reduce to 260.
+ * but if checkout relative long path name, its length too short.
+ * thus, expand length.
+ */
+#ifdef PATH_MAX
+#undef PATH_MAX
+#endif
+#define PATH_MAX 4096
+#endif
=20
 #ifndef PRIuMAX
 #define PRIuMAX "llu"
--=20
1.8.1.2

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
