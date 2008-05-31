From: Jamis Buck <jamis@37signals.com>
Subject: [PATCH] Honor git-reset -q by silencing progress updates.
Date: Sat, 31 May 2008 15:41:54 -0600
Message-ID: <32206B67-D97A-459E-BA48-D3B343D775F3@37signals.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/signed; boundary=Apple-Mail-10--112802933; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 23:42:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Yqh-0005ig-7D
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 23:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYEaVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 17:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbYEaVl6
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 17:41:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:51986 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbYEaVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 17:41:57 -0400
Received: by wa-out-1112.google.com with SMTP id j37so202679waf.23
        for <git@vger.kernel.org>; Sat, 31 May 2008 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:mime-version:subject:date:x-mailer:sender;
        bh=KyWRVz/7idb/Qq4ojlti/HNd7qNiqA10/urrcQ18QEk=;
        b=iDjnuLmuONFen83ObUjHB/5a9KrHEdGSgCkjnpriwAE/Lv/9pZlyp6UcGgG309Z+nk/P/yJ8QvLxhMIO3YRzWDiu0IC+znWGVuGDstBPUr2FtIKpJLyIsjVUseFc7nHZr9poq/2aBVXRviSYLWdjgX983JvlZa1lWLXwawjjh4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:mime-version:subject:date:x-mailer:sender;
        b=C8z7jfeIX2ZRRIv7Y5fx9JKcSQH6JZtH0tGvT+9ffyERkx1RJ7PnBabwKmeF+ltawLF4hqVfZPoBhu48SheG2onIQ1Sc4CNK4Rc14YC0Biso8q2G3A/1db3xzqp9RyhIBVsrB57TfE54jzArbv68mnVN8zzEP6CgKO/tfxei0OE=
Received: by 10.114.124.12 with SMTP id w12mr7894879wac.210.1212270116363;
        Sat, 31 May 2008 14:41:56 -0700 (PDT)
Received: from ?192.168.10.101? ( [71.33.110.14])
        by mx.google.com with ESMTPS id k37sm2508984waf.31.2008.05.31.14.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 14:41:56 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83406>


--Apple-Mail-10--112802933
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

When running git-reset in a non-interactive setting, the -q switch
works for everything except the progress updates. This patch attempts
to extend the application of -q to suppress that, too.
---
builtin-reset.c |    9 +++++----
1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index e32ddd9..3810f6d 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -49,13 +49,14 @@ static inline int is_merge(void)
	return !access(git_path("MERGE_HEAD"), F_OK);
}

-static int reset_index_file(const unsigned char *sha1, int  
is_hard_reset)
+static int reset_index_file(const unsigned char *sha1, int  
is_hard_reset, int quiet)
{
	int i = 0;
	const char *args[6];

	args[i++] = "read-tree";
-	args[i++] = "-v";
+	if (!quiet)
+		args[i++] = "-v";
	args[i++] = "--reset";
	if (is_hard_reset)
		args[i++] = "-u";
@@ -182,7 +183,7 @@ int cmd_reset(int argc, const char **argv, const  
char *prefix)
		OPT_SET_INT(0, "hard", &reset_type,
				"reset HEAD, index and working tree", HARD),
		OPT_BOOLEAN('q', NULL, &quiet,
-				"disable showing new HEAD in hard reset"),
+				"disable progress and showing new HEAD in hard reset"),
		OPT_END()
	};

@@ -231,7 +232,7 @@ int cmd_reset(int argc, const char **argv, const  
char *prefix)
		if (is_merge() || read_cache() < 0 || unmerged_cache())
			die("Cannot do a soft reset in the middle of a merge.");
	}
-	else if (reset_index_file(sha1, (reset_type == HARD)))
+	else if (reset_index_file(sha1, (reset_type == HARD), quiet))
		die("Could not reset index file to revision '%s'.", rev);

	/* Any resets update HEAD to the head being switched to,
-- 
1.5.5.1


--Apple-Mail-10--112802933
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGJzCCAuAw
ggJJoAMCAQICED+ol6E8S5s+zn8eEnnx8DIwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDkyNTIxMzc0N1oXDTA4MDkyNDIxMzc0
N1owRTEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEiMCAGCSqGSIb3DQEJARYTamFt
aXNAMzdzaWduYWxzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM07jxxBzB+s
jEPGey1UMX1d05g9b8uRwJtBzM7blxOj8NMkP3y8ZL3sT46VdtZLkOUdQUzGbRiQZECBBVGEH066
dZGrnTRh4nAQdmwe35EkWZkPISi8mVzPrKgAorytiBHUxdM2qmsI1787Qg2Exenlcc6RcrcIGZ2/
f/lSa/RRKsOlIAEN+aNkswqjV24I7Ab2p37PZg8Geae2XaacZBUsGiKcpqOW4+MYXhpmmt3jD+Hy
O39F/HeWUdP1VDzuQmHRWf30xQcF9M1N/agltBm0d1Y6Bdnv5SQPa/lpgCQBjOvub/nK6Ck9+KcI
phAx/cl+41/+IR2tJOoTh+4yAOcCAwEAAaMwMC4wHgYDVR0RBBcwFYETamFtaXNAMzdzaWduYWxz
LmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAIWksHvnVfsFekRPsw2+x7XT8mgy
bB7xo6lfUIf2XlMe/q6S43+gwzCoo7ArxEG19jRNkt5BbBjN12EX31ZYXhiEI6vSwIq66SyIQP8Q
BxueMBqYvQhBtyasPoKBtL63RRoAVpblaeFnuqqcqU3gZpuek00wP9dU6yQiK55hTNgnMIIDPzCC
AqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rl
cm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEo
MCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3Rl
IFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDE
pjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J
8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9IBH+n
ttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0fBDwwOjA4
oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxDQS5jcmww
CwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwyLTEzODAN
BgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0
HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghO
rvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAxAwggMMAgEBMHYwYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA/qJehPEubPs5/HhJ58fAyMAkGBSsOAwIa
BQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDUzMTIx
NDE1NVowIwYJKoZIhvcNAQkEMRYEFNvx7WsK6rzBNFqyFCCT+Zv5QzazMIGFBgkrBgEEAYI3EAQx
eDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQP6iXoTxLmz7O
fx4SefHwMjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIQP6iXoTxLmz7Ofx4SefHwMjANBgkqhkiG9w0BAQEFAASCAQAbxwi7S8LV
SSiWpLeThwp7DyapuJen40PxMvzff33qjallUET8uzwmAwncJ83mUqEgaEg8XJOSVenwto1JHN+0
XXhGeksXPB/xLjjFqb/yxABXhDL/ZKKwf/LCqjLgxovDxVlZ1a4NI8tmOR4yu+yxWSLv/kAsYLBc
ACfhIlkuligPIAi0ZY5ynB73WvGLN2eP8iHNiFJKSROoik292lBgeJI48N3cJzYDD9QyId0hdBrd
nwhJsBGizQkfVL7iI+FzcNt8XoQCU2S3L5LHFqbISnnJNnLN1nzo/TJTOGMh6+VFZWiWzou7fjzN
r8kAItObJ3t8ldt1Pp1wnitzARDcAAAAAAAA

--Apple-Mail-10--112802933--
