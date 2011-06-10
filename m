From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] zlib only processes 4GB at a time
Date: Fri, 10 Jun 2011 13:15:42 -0700
Message-ID: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87Z-00061E-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081Ab1FJUPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:15:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758034Ab1FJUPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:15:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D06E423E
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:17:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=BWrRSts0Or8g9dEHUR9R/c7IKl4
	=; b=ux2xYoLS7v+ruwjjePOy5Gl4zYktl8Px161rGA/vShxHV1ivL3UwQIhgOEN
	TML9F46nOKH6HTYEAfUakHso/lGeik4eO5At1YKVfAq31nuNqxUiST/FXZrzNi0o
	RSk01Ex6chVhRkLofWS58HJmvYMS30FsCTOzMAh60+ZN1KbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=KH5zNcSnmZboJqe6+EbwF/64o5EgA
	59+JgjETmIb91+Q0P8h1MYMN7XromLWKVuJ8O6iCFh7D82z+UNVxM41NkOrcoDMv
	scoes0vaS/dnlD+jh/3O93QRawhuhkhEG+KdRpR0pNOqq8mWcqfbpBjmpnlLy1AR
	wWr3ynV3t3ulA4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77705423D
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:17:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C33EF423C for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:17:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
X-Pobox-Relay-ID: BC430802-939E-11E0-A88D-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175618>

This is a re-roll from yesterday's series, taking a very different
approach. Instead of fixing call sites one by one, the goal is to define
our own API that can give an illusion to the callers that they can feed
and receive data whose size can fit within "unsigned long", so that they
can set up the avail_in field of z_stream (now git_zstream) to the total
size, and expect it to fall down to zero when everything is consumed by
the library (vice versa for avail_out).

The first 5 patches clean up the existing callers that directly call into
zlib to call git_inflate and git_deflate wrappers.

Patch 6 introduces git_zstream that is a thin wrapper around z_stream,
but barfs when the caller gives a buffer larger than 4GB that would fit
the underlying zlib calling convention.

The next step would be to tweak zlib_post_call(), git_inflate() and
git_deflate() functions to internally loop and call underlying inflate()
and deflate() when the incoming buffers are larger than 4GB, but that
part is not done in this series (yet).

Junio C Hamano (6):
  zlib: refactor error message formatter
  zlib: wrap remaining calls to direct inflate/inflateEnd
  zlib: wrap inflateInit2 used to accept only for gzip format
  zlib: wrap deflate side of the API
  zlib: wrap deflateBound() too
  zlib: zlib can only process 4GB at a time

 archive-zip.c            |   10 +-
 builtin/apply.c          |    2 +-
 builtin/index-pack.c     |   12 ++--
 builtin/pack-objects.c   |   18 ++--
 builtin/unpack-objects.c |    2 +-
 cache.h                  |   30 +++++--
 diff.c                   |   10 +-
 fast-import.c            |   30 +++---
 http-backend.c           |   11 +--
 http-push.c              |   16 ++--
 http.h                   |    2 +-
 pack-check.c             |    4 +-
 remote-curl.c            |   14 +--
 sha1_file.c              |   28 +++---
 zlib.c                   |  218 +++++++++++++++++++++++++++++++++++++++-------
 15 files changed, 283 insertions(+), 124 deletions(-)

-- 
1.7.6.rc1.118.ge175b4a
