From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/12] writing out a huge blob to working tree
Date: Fri, 20 May 2011 23:56:23 -0700
Message-ID: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg7A-0005vl-Jp
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab1EUG4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:56:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1EUG4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:56:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E96FC5D8B
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:58:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=ZI0z9wE3AWXktmwSfCXUEcb6m/I
	=; b=lRJ3AXotL53x9FZMdjFcX89uZqoXAEXVZA1xPHxhWUltNm44h+4QrsAiTRr
	E0i6eUJNxvRlyrE4MGM3J0XBkvvKpwAkazy5QkSLwGVAI2jr708wTPYFKP0RBpX6
	GHNUwCYu/d/qOhvtec0j3yXBRtFdTBaRTkEPqpX7eWXvTkLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=qqKECm106idY83wuUytvhz94mlOv2
	wmKeG9pTSPB8bxJ/kwx1bp4jKruCXUAoLY4xQ3wWxJ/kQBVENVi6tKQqXldeMVzl
	tVjot1s+lYGiO7SB7Bd1E8b9hkg+9a/LKgmH0ho5c8S/HbU9GQBnj0DjHUPQJbUJ
	nw6i7UfA1fKwRo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D35DE5D89
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:58:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 298A15D88 for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:58:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
X-Pobox-Relay-ID: C4D2C64C-8377-11E0-89B7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174094>

This third round fixes to the embarrasing 'result |= close(fd)' bug I
reported earlier, and issues Rene noticed in 03 (enum that added
OI_DBCACHED had a trailing comma in it) and 06 (remove unused "src" from
the git_istream object, do not try to use size field of NULL object, and
do not free NULL pointer).

Patch 08 is new. We can pass through the repository content to the working
tree under crlf=input conversion.

Junio C Hamano (12):
  packed_object_info_detail(): do not return a string
  sha1_object_info_extended(): expose a bit more info
  sha1_object_info_extended(): hint about objects in delta-base cache
  unpack_object_header(): make it public
  write_entry(): separate two helper functions out
  streaming: a new API to read from the object store
  streaming_write_entry(): use streaming API in write_entry()
  convert: CRLF_INPUT is a no-op in the output codepath
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
 streaming.c           |  371 +++++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h           |   15 ++
 8 files changed, 592 insertions(+), 40 deletions(-)
 create mode 100644 streaming.c
 create mode 100644 streaming.h

-- 
1.7.5.2.369.g8fc017
