From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Falling back "diff -C -C" to "diff -C" more gracefully
Date: Thu,  6 Jan 2011 13:50:03 -0800
Message-ID: <1294350606-19530-1-git-send-email-gitster@pobox.com>
References: <1juopju.rh4v4z97i9hmM%lists@haller-berlin.de>
 <7vhbdlahnp.fsf@alter.siamese.dyndns.org>
Cc: lists@haller-berlin.de (Stefan Haller)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 22:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaxjE-0005g3-QZ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1AFVuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:50:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab1AFVuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:50:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BFB92314F;
	Thu,  6 Jan 2011 16:50:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:references:in-reply-to; s=sasl; bh=2uLR
	Xjd4EU31838qN/o5bk9sV/w=; b=WYShfmH9gzQAhP/O/GMX7hEhvsNETZb1R+bB
	7od/OHLS7r95rpqtt4RyutZT121SCgg3ndHLbyb0v8uwkXS82FC1XfBeYbn5tbLf
	ycCf0Y7riT0oIx4o64CX/FkZMrNsbPukvrKeu3BakPJYlx5hAK8vwhHiiY+djN/L
	lJs0ZjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:references:in-reply-to; q=dns; s=sasl; b=
	ZNwkt0l1sKU4Q8l0l4SXgNZUl29lKwC8PrC8BO5BH9/9f9C8sV2aeFq+oRjkPD03
	md6a4DDOuz4A992Ph1zZqvkAJBIjtpXtnoZvZ6FlQ7M5BnFm+y6ltTxqFjbvqNgZ
	1hMX45v2M0yyxBeBNDXbSYz3+UieJhRGOdOUzVDhYm8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC0A8314C;
	Thu,  6 Jan 2011 16:50:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CF5F23148; Thu,  6 Jan 2011
 16:50:45 -0500 (EST)
X-Mailer: git-send-email 1.7.4.rc1.214.g2a4f9
In-Reply-To: <7vhbdlahnp.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 05315EA4-19DF-11E0-A05D-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164679>

In a project with many paths, "diff -C -C" may have too many rename source
candidates (as it tries to use all existing paths) but the rename source
candidates "diff -C" would use may still fit under the rename detection
limit.  Currently, we punt and disable the inexact rename detection
altogether even in such a case.

This weatherballoon series illustrates how diffcore-rename can be tweaked
to allow "-C -C" to fall back to "-C".  Somebody should write a test, but
not today ;-).

Junio C Hamano (3):
  diffcore-rename: refactor "too many candidates" logic
  diffcore-rename: record filepair for rename src
  diffcore-rename: fall back to -C when -C -C busts the rename limit

 diffcore-rename.c |   97 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 71 insertions(+), 26 deletions(-)

-- 
1.7.4.rc1.214.g2a4f9
