From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/18] mark file-local symbols static
Date: Mon, 11 Jan 2010 23:52:43 -0800
Message-ID: <1263282781-25596-1-git-send-email-gitster@pobox.com>
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thiago Farina <tfransosi@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaZ-00056x-58
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab0ALHyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378Ab0ALHxV
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab0ALHxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E711C8E881;
	Tue, 12 Jan 2010 02:53:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=eOIME78dLEBxYq7smVtVBJXCSyM
	=; b=kgieS/sXfU41uTDLG2dUFiWnzcGTv1bcCqkk23wU5r+SCAHAsBqO+Ndh5sB
	65w+R+ZXIO9PnpjYBT4X4cgzJA6JN5286JDY7PPFHpWEDdKPoQQ0lfIXNf60HLRk
	M1uuI6j7cpl0H7rszvjXr+kzXkkn8+9Dhx02ThMuN8c2yaQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=wazaqL36D1PLXhXhohzAA
	IZcCnDsp1T5DFOFGM4MwigAWMk3XA4/kUPefNHytDaO/r1RHgX/KY6p9e4RncIEL
	kgN1yu3g25lDloTuFRGNHerZ9HP56RXYcSHD9xKK1tu8Ru8XVZr9uEshON5H2yTo
	5fLAqk36kCZOkVb7Sm/yk4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7884A8E86D;
	Tue, 12 Jan 2010 02:53:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CC048E866; Tue, 12 Jan
 2010 02:53:03 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
X-Pobox-Relay-ID: 8743D378-FF4F-11DE-8A02-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136699>

The early part of the series up to [PATCH 12/18] are uncontroversial; they
all change "extern" symbols that are not used outside of the file they are
defined in to "static".

The remainder remove functions that are not called from anywhere.  While
the result of applying these patches still compiles, I find removal of
some are iffy:

 * map_email(), has_pack_file() and strbuf_tolower() are not even
   documented.  They should go.  It is trivial to reimplement them when a
   new caller needs it.

 * Even though parse_blob() in blob.c is never called, it is part of the
   "object layer" suite that consistently defines their initializers as
   parse_$type().  But it has never been called by anybody since its
   inception at a510bfa (Mark blobs as parsed when they're actually
   parsed, 2005-04-28).

   By the way, Documentation/technical/api-object-access.txt needs some
   love.

 * object_list_append() and object_list_length() in object.c do not have
   any callers, and they are implementations of rather inefficient API.
   Perhaps they should go.

 * I am a bit worried about nobody calling invalidate_lstat_cache() and
   clear_lstat_cache().  Kjetil introduced them in aeabab5 (lstat_cache():
   introduce invalidate_lstat_cache() function, 2009-01-18) and bda6eb0
   (lstat_cache(): introduce clear_lstat_cache() function, 2009-01-18)
   respectively but as far as I can tell there wasn't any user of these
   functions, ever.  They may be broken and nobody knew they were as
   nothing calls them, but more importantly it could be that some existing
   codepaths aren't calling them when they should.

In this series, I am not removing alloc_report(), print_string_list(), and
unsorted_string_list_has_string().  Among these three, the first two are
clearly for debugging and the latter two are documented interfaces, even
though nobody uses them.

I've made sure that they apply to 'master', 'next' and 'pu' (application
to 'pu' has two conflicts that are trivial in 04/18 and 08/18) and the
result compiles.

Junio C Hamano (18):
  bisect.c: mark file-local function static
  builtin-rev-list.c: mark file-local function static
  pretty.c: mark file-local function static
  date.c: mark file-local function static
  http.c: mark file-local functions static
  entry.c: mark file-local function static
  parse-options.c: mark file-local function static
  read-cache.c: mark file-local functions static
  remote-curl.c: mark file-local function static
  quote.c: mark file-local function static
  submodule.c: mark file-local function static
  utf8.c: mark file-local function static
  mailmap.c: remove unused function
  sha1_file.c: remove unused function
  strbuf.c: remove unused function
  blob.c: remove unused function
  object.c: remove unused functions
  symlinks.c: remove unused functions

 bisect.c           |    2 +-
 bisect.h           |    2 --
 blob.c             |   21 ---------------------
 blob.h             |    2 --
 builtin-rev-list.c |    2 +-
 cache.h            |    8 --------
 commit.h           |    1 -
 date.c             |    2 +-
 entry.c            |    2 +-
 git-compat-util.h  |    1 -
 http.c             |   10 ++++++++--
 http.h             |    9 ---------
 mailmap.c          |    5 -----
 mailmap.h          |    1 -
 object.c           |   21 ---------------------
 object.h           |    5 -----
 parse-options.c    |    7 +++++--
 parse-options.h    |    3 ---
 pretty.c           |    2 +-
 quote.c            |    2 +-
 quote.h            |    1 -
 read-cache.c       |    6 ++++--
 remote-curl.c      |    2 +-
 sha1_file.c        |    8 --------
 strbuf.c           |    7 -------
 strbuf.h           |    1 -
 submodule.c        |    2 +-
 symlinks.c         |   31 -------------------------------
 utf8.c             |    2 +-
 utf8.h             |    1 -
 30 files changed, 26 insertions(+), 143 deletions(-)
