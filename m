From: Stan Hu <stanhu@gmail.com>
Subject: [PATCH] upload-pack: Exit when server finishes sending shallow-update in stateless RPC mode
Date: Mon, 11 Apr 2016 21:55:40 -0700
Message-ID: <1460436940-16165-1-git-send-email-stanhu@gmail.com>
Cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 12 06:55:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apqMi-0001nM-CS
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 06:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcDLEzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 00:55:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33194 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcDLEzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 00:55:47 -0400
Received: by mail-pa0-f43.google.com with SMTP id zm5so6194536pac.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M/CiaMmO/6FHphlsMx+tvRuCF8QztrKtYDyZmK0CfZE=;
        b=v1FYK7SRh2pKCxLi3W/hnz/RtM3A6R00Am5mPJbIVvYYkULv1tip2pr4LiZ/Tto5d4
         mdSldL6Bl51+vuYfShBjqF9jSCB8WLe0NGkR7ue4GCN1OvCqZhTq+0ckGz81jH+ZeEZ6
         mRwma9sTa44IIeAp9YvdnQZZZ2wq2WdTJwaH5b8t0uwyvpp1eSdiAUtujv3cT7FR/YqZ
         Djuem5pMhZndv8HLg6n1AAh2rH83jYFmsjGBcy1opjQl5ujMWkQPTeEMb/Mip7HI2d8T
         zLZkomYaGcrGyK9LxaNpH04uJ553GfvPR6mX2M96uXrmcDsCEKfQSzpe2dCW+fXSsJ+9
         vO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/CiaMmO/6FHphlsMx+tvRuCF8QztrKtYDyZmK0CfZE=;
        b=g/iYLQc15O3Vcp03nyievVLbzHFBrdVY4GuAECgibU17DyaRNT5//G3aS0C9tpdYOp
         9vN2ONuYkw9lpZl5zbqupApUptlh+LDdguSJpZUWQIFUB1wse6dWKb9XNfjJZspdnIYY
         fq5JtQBCbgOzBtLaJKnHXd0FpFE38WrfikbiXc4LGR6NpU+iGrEoPAk+zM4G7tkiT8zb
         8EN8toj5fKiLHL0/sv5NAxBsyf3Zz7mB35jiosR0zFmIbjAbL7AfG0u7YSOK/gDue/VE
         4VyKDInR1ojph/8JelNZyB3VYOJwv/Q2keePA+8XnSarQMO1voM/ly1L22TixG2aBbfh
         guMQ==
X-Gm-Message-State: AOPr4FW5GZUjIAtN15Qw1hdHnrs9HrLi7ekYjMbHBQKypci30cCK3c9CTPNz5rmwdpB49A==
X-Received: by 10.66.33.1 with SMTP id n1mr1771547pai.65.1460436946066;
        Mon, 11 Apr 2016 21:55:46 -0700 (PDT)
Received: from smtp.gmail.com (c-24-6-246-163.hsd1.ca.comcast.net. [24.6.246.163])
        by smtp.gmail.com with ESMTPSA id z68sm39712152pfi.19.2016.04.11.21.55.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 11 Apr 2016 21:55:45 -0700 (PDT)
Received: by smtp.gmail.com (Postfix, from userid 501)
	id E8AA09341419; Mon, 11 Apr 2016 21:55:41 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291244>

In the stateless RPC case, the server should respond to the client's depth
request with the set of commits which are no deeper than the desired
depth. Once this finishes, the server should terminate and receive the reply
in another POST request.

Previously the server would sit idle and die when it detected the client
closed the connection.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 upload-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index b3f6653..4fb1e60 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -676,6 +676,8 @@ static void receive_needs(void)
 			register_shallow(object->oid.hash);
 		}
 		packet_flush(1);
+		if (stateless_rpc)
+			exit(0);
 	} else
 		if (shallows.nr > 0) {
 			int i;
-- 
2.7.3
