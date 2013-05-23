From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] git-send-email: fix handling of special characters
Date: Thu, 23 May 2013 16:54:18 +0300
Message-ID: <20130523135418.GA20741@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 15:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfVxx-0008CV-3E
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 15:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758440Ab3EWNx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 09:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020Ab3EWNx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 09:53:56 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NDruGY030661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 23 May 2013 09:53:56 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4NDrs1X014968
	for <git@vger.kernel.org>; Thu, 23 May 2013 09:53:55 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225247>

When patch sender's name has special characters,
git send-email did not quote it before matching
against the author name.
As a result it would produce mail like this:

	Date: Thu, 23 May 2013 16:36:00 +0300
	From: "Michael S. Tsirkin" <mst@redhat.com>
	To: qemu-devel@nongnu.org
	Cc: "Michael S. Tsirkin" <mst@redhat.com>
	Subject: [PATCH 0/9] virtio: switch to linux headers
	Message-Id: <1369316169-20181-1-git-send-email-mst@redhat.com>

	From: "Michael S. Tsirkin" <mst@redhat.com>

Fix by sanitizing before matching to patch author name.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..c4dc438 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1400,7 +1400,8 @@ foreach my $t (@files) {
 		$subject = quote_subject($subject, $auto_8bit_encoding);
 	}
 
-	if (defined $author and $author ne $sender) {
+	my $sanitized_sender = sanitize_address($sender);
+	if (defined $author and $author ne $sanitized_sender) {
 		$message = "From: $author\n\n$message";
 		if (defined $author_encoding) {
 			if ($has_content_type) {
-- 
MST
