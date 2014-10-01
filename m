From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 22/38] git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
Date: Wed,  1 Oct 2014 12:28:26 +0200
Message-ID: <1412159322-2622-23-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBG-0003Cb-7g
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbaJAKam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:30:42 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42039 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656AbaJAK32 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:28 -0400
X-AuditID: 12074413-f79ed6d000002501-0e-542bd7872165
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 15.AD.09473.787DB245; Wed,  1 Oct 2014 06:29:27 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6L026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:25 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1G2/rh1i8LhVwqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oy3BxuZClawVjx+5NLAuJili5GT
	Q0LARGLFix/sELaYxIV769m6GLk4hAQuM0qsXLqMFcI5ziSx5OYvsCo2AV2JRT3NTCC2iICa
	xMS2QywgRcwCi5kkJhzaxAaSEBaIl+idPglsBYuAqsTuHQvAmnkFXCS+zZsBtU5OYsPu/4wg
	NidQfPnlZrB6IQFniR13vjJNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0Qv
	NaV0EyMkGIV3MO46KXeIUYCDUYmHVyFBO0SINbGsuDL3EKMkB5OSKO+iS0AhvqT8lMqMxOKM
	+KLSnNTiQ4wSHMxKIrzZB4ByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkO
	DiUJXoZrQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2ivM0g7
	b3FBYi5QFKL1FKMxR0vT214mjnWd3/qZhFjy8vNSpcR5Q68ClQqAlGaU5sEtgqWhV4ziQH8L
	80qDDOQBpjC4ea+AVjEBrUpeA7aqJBEhJdXAqBaU3MvOUVV0LWtlH5fh1lS92/ck7vKc8V4X
	cmrNO/Fjr/J+TtnQce//d0PWX+paTc+M9lyfE7t9yWl752ebOrxdHb8LTmj1YbTn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257728>

After commit_lock_file() is called, then the lock_file object is
necessarily either committed or rolled back.  So there is no need to
call rollback_lock_file() again in either of these cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index a677eb6..123ed29 100644
--- a/config.c
+++ b/config.c
@@ -2083,6 +2083,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	if (commit_lock_file(lock) < 0) {
 		error("could not commit config file %s", config_filename);
 		ret = CONFIG_NO_WRITE;
+		lock = NULL;
 		goto out_free;
 	}
 
-- 
2.1.0
