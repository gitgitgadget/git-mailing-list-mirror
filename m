From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHES 9-12/12] line_buffer: more wrappers around stdio functions
Date: Sun, 2 Jan 2011 21:03:28 -0600
Message-ID: <20110103030328.GA10143@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 04:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZakw-0008TF-Kv
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 04:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1ACDDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 22:03:39 -0500
Received: from mail-yx0-f194.google.com ([209.85.213.194]:35245 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab1ACDDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 22:03:39 -0500
Received: by yxd5 with SMTP id 5so3188107yxd.1
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 19:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KMObCgi6re2BanRX8KlXPfiSJQmDr0PS9FJlFI9cYE0=;
        b=eHagPhayU/ZMLOX/wrjptar8bJMTuj9FpdWzHVyCdrXDE7SdWKTgL6X8TwWDnTL08U
         M5LGcv1JTL9rHwcGDVLw5MuM7qRNWaROi1lzmfSjdSs5oOx0dg5fyDh7cGKYOTEe+QX6
         Bado+CaLy3akHy2CyeIDdNxOsqACvarql/gTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DSVpAgFPTKQSEUDNgrJuTncnC/yJ1CTn+zSMO0FFF2982eMfbfBkAeeioSeth+Njge
         YAHu3KgQXGqTwnhj3/HkC9KA8S3qgZdiq7QYunTKK02yb3DaM1xJDjM+M1zEDImfMBdk
         7WE4n2KVnHKnS5U2EnEqdpTu5S+82XSKsc4qA=
Received: by 10.100.109.19 with SMTP id h19mr6402543anc.4.1294023818186;
        Sun, 02 Jan 2011 19:03:38 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id i10sm27509665anh.32.2011.01.02.19.03.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 19:03:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103004900.GA30506@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164437>

This might be the last batch of line_buffer patches for the moment[1].
It introduces wrappers around strbuf_fread, fgetc, fdopen, and tmpfile
so the line_buffer lib can do what those functions do.

The motivation in the background is delta application.  We need:

 - binary-safe input, since svn (like most version control systems)
   gets used to store binary files from time to time.
 - character-oriented input (fgetc) as a basic convenience, needed in
   particular for reading variable-length integers in svndiff blocks.
 - input from file descriptors, to read information requested from
   fast-import (in particular, delta preimages).
 - temporary files, to store the result of delta application and
   retrieve its length so svn-fe can write

	data <length>
	... delta application result ...

   to fast-import.

The ideas behind the third and fourth patches (patches 11 and 12) are
from David Barr's earlier work in the same direction.  Patches are
based against

  [PATCH 8/8] t0081 (line-buffer): add buffering tests

so we can reuse some of the testing infrastructure.  They are numbered
accordingly for easy application.

Each patch introduces new API.  I would be happy if you can find an
infelicity or two so we can fix the functions now before people get
used to them.

Jonathan Nieder (4):
  vcs-svn: add binary-safe read function
  vcs-svn: allow character-oriented input
  vcs-svn: allow input from file descriptor
  vcs-svn: teach line_buffer about temporary files

 t/t0081-line-buffer.sh  |   27 +++++++++++++++++++++++++++
 test-line-buffer.c      |   21 ++++++++++++++++++---
 vcs-svn/line_buffer.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/line_buffer.h   |   10 +++++++++-
 vcs-svn/line_buffer.txt |   31 +++++++++++++++++++++++++++----
 5 files changed, 124 insertions(+), 8 deletions(-)

[1] There's another patch to use 64-bit offsets but the API changes
are more obvious.
