From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a fast version of fstat to cygwin port
Date: Thu, 19 Mar 2009 15:30:12 +0100
Message-ID: <81b0412b0903190730s40589291iea9a861ddeedcc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e1d8a501e4f046579a360
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 15:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJHh-00075o-L2
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 15:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbZCSOaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 10:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbZCSOaR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 10:30:17 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:46252 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbZCSOaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 10:30:16 -0400
Received: by an-out-0708.google.com with SMTP id d14so414377and.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=jTMGHffyVdH73+a3IPkqLdDlNbSuTwfybO2fIelG/tU=;
        b=VOkwRp7UzPESfst7UwzRtoAEJIKshREK77Z2NcUE/ynbF5hZXFGP4v7bQxKAcadH+1
         /kvCgbFSB/Znb4PGwa63CzPPSRSXdz4LPCRrxsaAZWNqG7NRM6jJ4phyto1Bcrs7BRYT
         16JG0AexkGMlXHJvjA2QfQgxIFbak5uokjuSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=wqX6eaNv8Qmvj9AtPfPnK3O9wnmFTU88RyfeH6pM/ABZvpF3NiZvCZSRvFvoiG7jk/
         BOeeyHJKLOGf8Fm+ehZ/j2iRg4mak/2g3GMcKJ7/W7wpO1y/y9WTUMm27FUcnaGP0chG
         Y41Xwdj126Q3k62KhenRh4pHZ/+F9Vo5HmHO8=
Received: by 10.101.67.11 with SMTP id u11mr2797028ank.45.1237473012226; Thu, 
	19 Mar 2009 07:30:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113772>

--0016368e1d8a501e4f046579a360
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Besides, the output of the fast stat and lstat is not compatible
with cygwin's fstat with regard to uid, gid and ctime fields.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This is not strictly related to the other stat patches. The fstat
code is shamelessly stolen from the mingw port, sorry.

BTW, why do we have to #undef fstat, but not stat/lstat?

 compat/cygwin.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 compat/cygwin.h |    2 +
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index ebac148..e91af4f 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -15,6 +15,18 @@ static inline void filetime_to_timespec(const
FILETIME *ft, struct timespec *ts)

 #define size_to_blocks(s) (((s)+511)/512)

+/*
+ * Initialize the fields of struct stat which this implementation
+ * considers constant on this platform. See also mingw.c
+ */
+static void dosify_statbuf(struct stat *buf)
+{
+	buf->st_dev = buf->st_rdev = 0; /* not used by Git */
+	buf->st_ino = 0;
+	buf->st_nlink = 1;
+	buf->st_uid = buf->st_gid = 0;
+}
+
 /* do_stat is a common implementation for cygwin_lstat and cygwin_stat.
  *
  * To simplify its logic, in the case of cygwin symlinks, this implementation
@@ -41,11 +53,8 @@ static int do_stat(const char *file_name, struct
stat *buf, stat_fn_t cygstat)
 			return cygstat(file_name, buf);

 		/* fill out the stat structure */
-		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
-		buf->st_ino = 0;
+		dosify_statbuf(buf);
 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
-		buf->st_nlink = 1;
-		buf->st_uid = buf->st_gid = 0;
 #ifdef __CYGWIN_USE_BIG_TYPES__
 		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
 			fdata.nFileSizeLow;
@@ -85,6 +94,41 @@ static int cygwin_stat(const char *path, struct stat *buf)
 	return do_stat(path, buf, stat);
 }

+#undef fstat
+static int cygwin_fstat(int fd, struct stat *buf)
+{
+	HANDLE fh = (HANDLE)_get_osfhandle(fd);
+	BY_HANDLE_FILE_INFORMATION fdata;
+
+	if (fh == INVALID_HANDLE_VALUE) {
+		errno = EBADF;
+		return -1;
+	}
+	/* direct non-file handles to cygwin's fstat() */
+	if (GetFileType(fh) != FILE_TYPE_DISK)
+		return fstat(fd, buf);
+
+	if (!buf) {
+		errno = EINVAL;
+		return -1;
+	}
+	if (GetFileInformationByHandle(fh, &fdata)) {
+		dosify_statbuf(buf);
+		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
+#ifdef __CYGWIN_USE_BIG_TYPES__
+		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
+			fdata.nFileSizeLow;
+#else
+		buf->st_size = (off_t)fdata.nFileSizeLow;
+#endif
+		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
+		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
+		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
+		return 0;
+	}
+	errno = EBADF;
+	return -1;
+}

 /*
  * At start up, we are trying to determine whether Win32 API or cygwin stat
@@ -119,9 +163,11 @@ static int init_stat(void)
 		if (!core_filemode && native_stat) {
 			cygwin_stat_fn = cygwin_stat;
 			cygwin_lstat_fn = cygwin_lstat;
+			cygwin_fstat_fn = cygwin_fstat;
 		} else {
 			cygwin_stat_fn = stat;
 			cygwin_lstat_fn = lstat;
+			cygwin_fstat_fn = fstat;
 		}
 		return 0;
 	}
@@ -138,6 +184,12 @@ static int cygwin_lstat_stub(const char
*file_name, struct stat *buf)
 	return (init_stat() ? lstat : *cygwin_lstat_fn)(file_name, buf);
 }

+static int cygwin_fstat_stub(int fd, struct stat *buf)
+{
+	return (init_stat() ? fstat : *cygwin_fstat_fn)(fd, buf);
+}
+
 stat_fn_t cygwin_stat_fn = cygwin_stat_stub;
 stat_fn_t cygwin_lstat_fn = cygwin_lstat_stub;
+int (*cygwin_fstat_fn)(int fd, struct stat *) = cygwin_fstat_stub;

diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..fd54c82 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -4,6 +4,8 @@
 typedef int (*stat_fn_t)(const char*, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
+extern int (*cygwin_fstat_fn)(int fd, struct stat *);

 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+#define fstat(fd, buf) (*cygwin_fstat_fn)(fd, buf)
-- 
1.6.2.142.gaf8db

--0016368e1d8a501e4f046579a360
Content-Type: application/octet-stream; 
	name="0001-Add-a-fast-version-of-fstat-to-cygwin-port.diff"
Content-Disposition: attachment; 
	filename="0001-Add-a-fast-version-of-fstat-to-cygwin-port.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fshja5px0

RnJvbSA0N2E2NmJmN2YwMzEwNmU1YzQ4ZjcwMDJhNjdhOTViYmM2OTU5Nzk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDE5IE1hciAyMDA5IDE1OjE4OjAwICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIGEg
ZmFzdCB2ZXJzaW9uIG9mIGZzdGF0IHRvIGN5Z3dpbiBwb3J0CgpCZXNpZGVzLCB0aGUgb3V0cHV0
IG9mIHRoZSBmYXN0IHN0YXQgYW5kIGxzdGF0IGlzIG5vdCBjb21wYXRpYmxlCndpdGggY3lnd2lu
J3MgZnN0YXQgd2l0aCByZWdhcmQgdG8gdWlkLCBnaWQgYW5kIGN0aW1lIGZpZWxkcy4KClNpZ25l
ZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogY29tcGF0L2N5
Z3dpbi5jIHwgICA2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0KIGNvbXBhdC9jeWd3aW4uaCB8ICAgIDIgKwogMiBmaWxlcyBjaGFuZ2VkLCA1
OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbXBhdC9jeWd3
aW4uYyBiL2NvbXBhdC9jeWd3aW4uYwppbmRleCBlYmFjMTQ4Li5lOTFhZjRmIDEwMDY0NAotLS0g
YS9jb21wYXQvY3lnd2luLmMKKysrIGIvY29tcGF0L2N5Z3dpbi5jCkBAIC0xNSw2ICsxNSwxOCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgZmlsZXRpbWVfdG9fdGltZXNwZWMoY29uc3QgRklMRVRJTUUg
KmZ0LCBzdHJ1Y3QgdGltZXNwZWMgKnRzKQogCiAjZGVmaW5lIHNpemVfdG9fYmxvY2tzKHMpICgo
KHMpKzUxMSkvNTEyKQogCisvKgorICogSW5pdGlhbGl6ZSB0aGUgZmllbGRzIG9mIHN0cnVjdCBz
dGF0IHdoaWNoIHRoaXMgaW1wbGVtZW50YXRpb24KKyAqIGNvbnNpZGVycyBjb25zdGFudCBvbiB0
aGlzIHBsYXRmb3JtLiBTZWUgYWxzbyBtaW5ndy5jCisgKi8KK3N0YXRpYyB2b2lkIGRvc2lmeV9z
dGF0YnVmKHN0cnVjdCBzdGF0ICpidWYpCit7CisJYnVmLT5zdF9kZXYgPSBidWYtPnN0X3JkZXYg
PSAwOyAvKiBub3QgdXNlZCBieSBHaXQgKi8KKwlidWYtPnN0X2lubyA9IDA7CisJYnVmLT5zdF9u
bGluayA9IDE7CisJYnVmLT5zdF91aWQgPSBidWYtPnN0X2dpZCA9IDA7Cit9CisKIC8qIGRvX3N0
YXQgaXMgYSBjb21tb24gaW1wbGVtZW50YXRpb24gZm9yIGN5Z3dpbl9sc3RhdCBhbmQgY3lnd2lu
X3N0YXQuCiAgKgogICogVG8gc2ltcGxpZnkgaXRzIGxvZ2ljLCBpbiB0aGUgY2FzZSBvZiBjeWd3
aW4gc3ltbGlua3MsIHRoaXMgaW1wbGVtZW50YXRpb24KQEAgLTQxLDExICs1Myw4IEBAIHN0YXRp
YyBpbnQgZG9fc3RhdChjb25zdCBjaGFyICpmaWxlX25hbWUsIHN0cnVjdCBzdGF0ICpidWYsIHN0
YXRfZm5fdCBjeWdzdGF0KQogCQkJcmV0dXJuIGN5Z3N0YXQoZmlsZV9uYW1lLCBidWYpOwogCiAJ
CS8qIGZpbGwgb3V0IHRoZSBzdGF0IHN0cnVjdHVyZSAqLwotCQlidWYtPnN0X2RldiA9IGJ1Zi0+
c3RfcmRldiA9IDA7IC8qIG5vdCB1c2VkIGJ5IEdpdCAqLwotCQlidWYtPnN0X2lubyA9IDA7CisJ
CWRvc2lmeV9zdGF0YnVmKGJ1Zik7CiAJCWJ1Zi0+c3RfbW9kZSA9IGZpbGVfYXR0cl90b19zdF9t
b2RlKGZkYXRhLmR3RmlsZUF0dHJpYnV0ZXMpOwotCQlidWYtPnN0X25saW5rID0gMTsKLQkJYnVm
LT5zdF91aWQgPSBidWYtPnN0X2dpZCA9IDA7CiAjaWZkZWYgX19DWUdXSU5fVVNFX0JJR19UWVBF
U19fCiAJCWJ1Zi0+c3Rfc2l6ZSA9ICgoX29mZjY0X3QpZmRhdGEubkZpbGVTaXplSGlnaCA8PCAz
MikgKwogCQkJZmRhdGEubkZpbGVTaXplTG93OwpAQCAtODUsNiArOTQsNDEgQEAgc3RhdGljIGlu
dCBjeWd3aW5fc3RhdChjb25zdCBjaGFyICpwYXRoLCBzdHJ1Y3Qgc3RhdCAqYnVmKQogCXJldHVy
biBkb19zdGF0KHBhdGgsIGJ1Ziwgc3RhdCk7CiB9CiAKKyN1bmRlZiBmc3RhdAorc3RhdGljIGlu
dCBjeWd3aW5fZnN0YXQoaW50IGZkLCBzdHJ1Y3Qgc3RhdCAqYnVmKQoreworCUhBTkRMRSBmaCA9
IChIQU5ETEUpX2dldF9vc2ZoYW5kbGUoZmQpOworCUJZX0hBTkRMRV9GSUxFX0lORk9STUFUSU9O
IGZkYXRhOworCisJaWYgKGZoID09IElOVkFMSURfSEFORExFX1ZBTFVFKSB7CisJCWVycm5vID0g
RUJBREY7CisJCXJldHVybiAtMTsKKwl9CisJLyogZGlyZWN0IG5vbi1maWxlIGhhbmRsZXMgdG8g
Y3lnd2luJ3MgZnN0YXQoKSAqLworCWlmIChHZXRGaWxlVHlwZShmaCkgIT0gRklMRV9UWVBFX0RJ
U0spCisJCXJldHVybiBmc3RhdChmZCwgYnVmKTsKKworCWlmICghYnVmKSB7CisJCWVycm5vID0g
RUlOVkFMOworCQlyZXR1cm4gLTE7CisJfQorCWlmIChHZXRGaWxlSW5mb3JtYXRpb25CeUhhbmRs
ZShmaCwgJmZkYXRhKSkgeworCQlkb3NpZnlfc3RhdGJ1ZihidWYpOworCQlidWYtPnN0X21vZGUg
PSBmaWxlX2F0dHJfdG9fc3RfbW9kZShmZGF0YS5kd0ZpbGVBdHRyaWJ1dGVzKTsKKyNpZmRlZiBf
X0NZR1dJTl9VU0VfQklHX1RZUEVTX18KKwkJYnVmLT5zdF9zaXplID0gKChfb2ZmNjRfdClmZGF0
YS5uRmlsZVNpemVIaWdoIDw8IDMyKSArCisJCQlmZGF0YS5uRmlsZVNpemVMb3c7CisjZWxzZQor
CQlidWYtPnN0X3NpemUgPSAob2ZmX3QpZmRhdGEubkZpbGVTaXplTG93OworI2VuZGlmCisJCWZp
bGV0aW1lX3RvX3RpbWVzcGVjKCZmZGF0YS5mdExhc3RBY2Nlc3NUaW1lLCAmYnVmLT5zdF9hdGlt
KTsKKwkJZmlsZXRpbWVfdG9fdGltZXNwZWMoJmZkYXRhLmZ0TGFzdFdyaXRlVGltZSwgJmJ1Zi0+
c3RfbXRpbSk7CisJCWZpbGV0aW1lX3RvX3RpbWVzcGVjKCZmZGF0YS5mdENyZWF0aW9uVGltZSwg
JmJ1Zi0+c3RfY3RpbSk7CisJCXJldHVybiAwOworCX0KKwllcnJubyA9IEVCQURGOworCXJldHVy
biAtMTsKK30KIAogLyoKICAqIEF0IHN0YXJ0IHVwLCB3ZSBhcmUgdHJ5aW5nIHRvIGRldGVybWlu
ZSB3aGV0aGVyIFdpbjMyIEFQSSBvciBjeWd3aW4gc3RhdApAQCAtMTE5LDkgKzE2MywxMSBAQCBz
dGF0aWMgaW50IGluaXRfc3RhdCh2b2lkKQogCQlpZiAoIWNvcmVfZmlsZW1vZGUgJiYgbmF0aXZl
X3N0YXQpIHsKIAkJCWN5Z3dpbl9zdGF0X2ZuID0gY3lnd2luX3N0YXQ7CiAJCQljeWd3aW5fbHN0
YXRfZm4gPSBjeWd3aW5fbHN0YXQ7CisJCQljeWd3aW5fZnN0YXRfZm4gPSBjeWd3aW5fZnN0YXQ7
CiAJCX0gZWxzZSB7CiAJCQljeWd3aW5fc3RhdF9mbiA9IHN0YXQ7CiAJCQljeWd3aW5fbHN0YXRf
Zm4gPSBsc3RhdDsKKwkJCWN5Z3dpbl9mc3RhdF9mbiA9IGZzdGF0OwogCQl9CiAJCXJldHVybiAw
OwogCX0KQEAgLTEzOCw2ICsxODQsMTIgQEAgc3RhdGljIGludCBjeWd3aW5fbHN0YXRfc3R1Yihj
b25zdCBjaGFyICpmaWxlX25hbWUsIHN0cnVjdCBzdGF0ICpidWYpCiAJcmV0dXJuIChpbml0X3N0
YXQoKSA/IGxzdGF0IDogKmN5Z3dpbl9sc3RhdF9mbikoZmlsZV9uYW1lLCBidWYpOwogfQogCitz
dGF0aWMgaW50IGN5Z3dpbl9mc3RhdF9zdHViKGludCBmZCwgc3RydWN0IHN0YXQgKmJ1ZikKK3sK
KwlyZXR1cm4gKGluaXRfc3RhdCgpID8gZnN0YXQgOiAqY3lnd2luX2ZzdGF0X2ZuKShmZCwgYnVm
KTsKK30KKwogc3RhdF9mbl90IGN5Z3dpbl9zdGF0X2ZuID0gY3lnd2luX3N0YXRfc3R1YjsKIHN0
YXRfZm5fdCBjeWd3aW5fbHN0YXRfZm4gPSBjeWd3aW5fbHN0YXRfc3R1YjsKK2ludCAoKmN5Z3dp
bl9mc3RhdF9mbikoaW50IGZkLCBzdHJ1Y3Qgc3RhdCAqKSA9IGN5Z3dpbl9mc3RhdF9zdHViOwog
CmRpZmYgLS1naXQgYS9jb21wYXQvY3lnd2luLmggYi9jb21wYXQvY3lnd2luLmgKaW5kZXggYTMy
MjlmNS4uZmQ1NGM4MiAxMDA2NDQKLS0tIGEvY29tcGF0L2N5Z3dpbi5oCisrKyBiL2NvbXBhdC9j
eWd3aW4uaApAQCAtNCw2ICs0LDggQEAKIHR5cGVkZWYgaW50ICgqc3RhdF9mbl90KShjb25zdCBj
aGFyKiwgc3RydWN0IHN0YXQqKTsKIGV4dGVybiBzdGF0X2ZuX3QgY3lnd2luX3N0YXRfZm47CiBl
eHRlcm4gc3RhdF9mbl90IGN5Z3dpbl9sc3RhdF9mbjsKK2V4dGVybiBpbnQgKCpjeWd3aW5fZnN0
YXRfZm4pKGludCBmZCwgc3RydWN0IHN0YXQgKik7CiAKICNkZWZpbmUgc3RhdChwYXRoLCBidWYp
ICgqY3lnd2luX3N0YXRfZm4pKHBhdGgsIGJ1ZikKICNkZWZpbmUgbHN0YXQocGF0aCwgYnVmKSAo
KmN5Z3dpbl9sc3RhdF9mbikocGF0aCwgYnVmKQorI2RlZmluZSBmc3RhdChmZCwgYnVmKSAoKmN5
Z3dpbl9mc3RhdF9mbikoZmQsIGJ1ZikKLS0gCjEuNi4yLjE0Mi5nYWY4ZGIKCg==
--0016368e1d8a501e4f046579a360--
