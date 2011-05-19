From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/11] writing out a huge blob to working tree
Date: Thu, 19 May 2011 14:33:35 -0700
Message-ID: <1305840826-7783-1-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:34:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAr1-0006FC-3V
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934822Ab1ESVdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:33:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab1ESVdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:33:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB9985299
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:35:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=C+fS
	fq2qD8YVP0M/b1CysDnLxOc=; b=hp9wpYQtunQOluE5JhAFWRMd8KNRbswGM0Yp
	aVcZ3yi+/W6Qo4DygL46A/MzF+3RIGlnR+Av7okXXBGnYY5VzSx0s1XqmTKLEWwX
	CRAi4/GZ7ba281yaca32pwKUq6WZt9QOV7okhJbl7kIK7Q1GHFk5oYgyUtqq719D
	kd4qmuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LdMdpp
	fmSvTpLrbs8c7H3e2F5xgsCLRzUNUae+PGo4KYqcHFX/OaqLZankCE46B1AXA7lG
	txnwaPtAW8Z8l/GLUlLLzl3QAI7Kfxcgh8k8u/nB5UprLAfE1wQ0D9MV3yZ4B1I+
	uW9NhRh+CgvxkvDgJW+6raSF4IR5mQJb8fUYE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C51915298
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:35:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E4335296 for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:35:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FB17D49A-825F-11E0-B6F9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174013>

So this is the second round. Peff noticed that the istream_open() did not
return the size of the object correctly for in-pack (non-delta) and loose
representations, and this round fixes it.

Also sha1_object_info_extended() lost the call to the expensive function
packed_object_info_detail(), as the only thing we are interested in is to
see if the first-level object is a non-delta.  As the result, 02/11 would
now be much easier to follow.

Junio C Hamano (11):
  packed_object_info_detail(): do not return a string
  sha1_object_info_extended(): expose a bit more info
  sha1_object_info_extended(): hint about objects in delta-base cache
  unpack_object_header(): make it public
  write_entry(): separate two helper functions out
  streaming: a new API to read from the object store
  streaming_write_entry(): use streaming API in write_entry()
  streaming_write_entry(): support files with holes
  streaming: read non-delta incrementally from a pack
  sha1_file.c: expose helpers to read loose objects
  streaming: read loose objects incrementally

 Makefile              |    2 +
 builtin/verify-pack.c |    4 +-
 cache.h               |   36 +++++-
 convert.c             |   23 +++
 entry.c               |  112 +++++++++++++---
 sha1_file.c           |   69 +++++++---
 streaming.c           |  377 +++++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h           |   15 ++
 8 files changed, 598 insertions(+), 40 deletions(-)
 create mode 100644 streaming.c
 create mode 100644 streaming.h

-- 
1.7.5.1.416.gac10c8
