From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] transfer.hiderefs
Date: Mon, 28 Jan 2013 16:13:29 -0800
Message-ID: <1359418412-26602-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 01:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzypq-0005Sy-C5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 01:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab3A2ANh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 19:13:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab3A2ANf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 19:13:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4700C7EB
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Bw0WXKHoyQKKPg42x5PovFEg8O4
	=; b=qfTllXHUZ4Tj+mCjyr4tUqFb3eTzbYCeHI7y2CAGVCOFTC3SeAyx632fnUq
	yNcwktK5ywedJ43otjf++dDmXQGMJxnTf8iZ0uSJbJsy17LBD69p6TzJxvy7p1Z0
	lvhkv8o1wY+1RTYfwhUX7djHGIC/wSVQ8vDCL2LOVJ5Xme+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=T2WLHXZ7FYZOK9ZMp2qgUmyfMUcfg
	0T+iL8LSoa/L+475OK2Pcm95GE2P2l33QNf4C20abwr85K9jSVJktmQ/B+6S3udK
	AuxvNmAJKi6TgA9Zl7L72rQSskxMA8Dd67kfn4v6eJUCDbZoGTwaxkGqTHXk6pXu
	+hHF8tj+ppP6Mk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA553C7E8
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69E05C7E7 for
 <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:34 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.548.g0e4986f
X-Pobox-Relay-ID: B871AB98-69A8-11E2-9A22-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214888>

So this is the second round, unifying the handling of "hidden refs"
a hosting site administrator may want to handle differently from
normal refs available to upload-pack and receive-pack.  Big thanks
to Peff for making me realize that what is shown to "git push"
should match what is shown to "git fetch/clone".

The configuration variable has been changed to "transfer.hiderefs"
in this round.  I picked refs.[ch] as the shared location to place
the machinery that deals with this configuration, but I am not proud
of the choice---there may be a more suitable place.

The third patch is new; it prevents a hidden ref to be deleted or
updated via "git push" to ensure that its contents are controlled
only from the server side using some side channel (e.g. pull-request
UI on the Web).

There is no "git fetch $there $exact_sha1_obtained_out_of_band"
yet; that must come next, together with a mechanism to control the
availability of it on the server side.

For those who missed it, the first round starts at 

    http://thread.gmane.org/gmane.comp.version-control.git/213951

Junio C Hamano (3):
  upload-pack: share more code
  upload-pack: allow hiding ref hiearchies
  receive-pack: reject an attempt to update/delete a hidden ref

 Documentation/config.txt |  9 +++++++++
 builtin/receive-pack.c   | 24 +++++++++++++++++++++++
 refs.c                   | 41 +++++++++++++++++++++++++++++++++++++++
 refs.h                   |  3 +++
 t/t5512-ls-remote.sh     |  9 +++++++++
 t/t5516-fetch-push.sh    | 24 +++++++++++++++++++++++
 upload-pack.c            | 50 ++++++++++++++++++++++++++++++++----------------
 7 files changed, 144 insertions(+), 16 deletions(-)

-- 
1.8.1.2.548.g0e4986f
