From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 14:27:46 -0600
Message-ID: <20101118202746.GG16610@burratino>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
 <1288299210-27092-2-git-send-email-gitster@pobox.com>
 <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
 <4CE55794.7050201@viscovery.net>
 <AANLkTikns0Rm5znC7FOa72qZXKpQzazKiYsPe-oDNMAk@mail.gmail.com>
 <20101118172920.GC16610@burratino>
 <AANLkTi=rrcc5tia03K-Rtqs3vyjOv9P1NArnmbYhCQ27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 21:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJB5z-0004BV-6a
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 21:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813Ab0KRU2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 15:28:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58671 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab0KRU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 15:28:32 -0500
Received: by vws13 with SMTP id 13so2013084vws.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 12:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PG1LEbXzujeiB+KWpP35mR/kcQRVmbtFPshQ/Q6bjy4=;
        b=dAMvtv5tsYUxGPr9y7S3vZ7w78+ZMdj6zoDaRz3K3RQnkLGoKKmmKvbif7/jAgDD1j
         fMjOXGdgDIdQfH5Dt1vYuv0r9SIQ8BxtexMgWcb+JYcwT30ZGUU6moAO9fWLwakjo1F1
         r5+iA1b4Y+N5+QOWtHSCq/jV0JywMfF5gS1+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kqPToJ6V7E7w4kQO/tePK/n/UdAIDv4Xdz4Lij0Auz9HJi+FLYNxi6YE9IVOvRZ7mk
         lSoOjMjFVA+YJ/BQkOMGY0OCNLs/hQnOJA4Fdkwj5Q+0Jtmiv8CZvddCYaEs6CsuXp5r
         LaXMmVHYl/BQ6Y9Dwknd0UNEbVy3aGx/Z+03s=
Received: by 10.220.166.4 with SMTP id k4mr252954vcy.177.1290112111426;
        Thu, 18 Nov 2010 12:28:31 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n38sm276724vba.15.2010.11.18.12.28.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 12:28:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=rrcc5tia03K-Rtqs3vyjOv9P1NArnmbYhCQ27@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161709>

Erik Faye-Lund wrote:

> We also seem to depend quite heavily on errno being preserved on
> non-errors some places around in the code.

Hmm, sounds worrying.

- builtin/fetch.c::s_update_ref appears to have some of this kind of
  bogosity.
- safe_create_leading_directories_const and git_config_set_multivar let
  free() touch errno.  Probably not a problem.
- lock_file ought to preserve or set errno on failure.
- daemon::run_service sometimes sets errno on failure and sometimes not.
  This is confusing even if callers don't seem to care.
- fast-import::dump_marks_helper ought to do its own error reporting.
- resolve_ref seems to rely on get_packed_refs not to clobber errno.
- sha1_file::open_packed_git_1 seems to rely on unuse_one_window not to
  clobber errno.

Aside from that:

The following does not take into account correctness of error
messages.  (That is probably a good reason to fix compat/mingw's
opendir.  Sorry, I forgot to take that into account before.)

Builtins
--------
apply.c:
	checks errno following lstat() failure.
	checks errno following try_create_file() return from
	 mkdir(), symlink(), or open() failure.
clone.c:	checks errno following mkdir() and unlink() failure.
commit.c:	saves errno following strbuf_read_file() failure.
fetch.c:
	checks errno following write_in_full(), close(), fopen() failure.
	see above for the s_update_ref() checks.
for-each-ref.c:	checks errno following strtol() failure.
grep.c:	checks errno following open() and lstat() failure.
index-pack.c:
	checks errno following open() failure.
	checks errno following odb_pack_keep() [= open()] failure.
init-db.c:	checks errno following mkdir(), lstat() failure.
log.c:	checks errno following mkdir() failure.
mailsplit.c:	checks errno following opendir() failure.
pack-objects.c:	checks errno following fgets() failure.
rm.c:	checks errno following lstat() failure.
update-index.c:
	checks errno following lstat() failure.
	relies on strtoul() not to clobber errno on success.
	checks errno following hold_locked_index() return from
	 lock_file() failure (see above).
upload-archive.c:
	checks errno following read(), pipe(), fork(), and poll() failure.

Compatibility routines
----------------------
cygwin.c, inet_ntop.c, mingw.c, and mmap.c use errno in
noncosmetic ways.  I haven't checked them.

git wrapper
-----------
git.c:	checks errno following run_command_v_opt() failure.

libgit
------
config.c:	checks errno following open() failure, with intervening free().
connect.c:	checks errno following connect(), socket() failure.
copy.c:	saves errno following xread(), xwrite() failure.
daemon.c:	checks errno following poll(), accept() failure.
diff-lib.c:	checks errno following lstat() failure.
diff.c:	checks errno following lstat() failure.
dir.c:	checks errno following unlink() failure.
entry.c:	checks errno following mkdir() failure.
fast-import.c:
	saves errno following fdopen(), fprintf(), fclose() failure.
	saves errno following commit_lock_file [=close() or rename()] failure.
	relies on strtoul() not to clobber errno on success.
git-compat-util.h:
	relies on strtoul(), strtol() not to clobber errno on success.
http.c:	checks errno following open() failure.
lockfile.c:	checks errno following open() failure.
merge-recursive.c:
	checks errno following write_in_full(), unlink() failure.
path.c:	checks errno following snprintf() failure.
read-cache.c:	checks errno following lstat(), open() failure.
refs.c:	see above for resolve_ref() worries.
rerere.c:	checks errno following fwrite(), unlink() failure.
run-command.c:
	checks errno following waitpid, pipe, fork, execv, failure.
	wait_or_whine() does not set errno when child died by signal.
setup.c:	checks errno following lstat() failure.
sha1_file.c:
	checks errno following open(), opendir() failure.
	see above re unuse_one_window() failure.
sha1_name.c:	checks errno following lstat() failure.
strbuf.c:	checks errno following readlink() failure.
symlinks.c:	checks errno following stat(), lstat() failure.
transport-helper.c:	checks errno following start_command() failure.
unpack-trees.c:	checks errno following lstat() failure.
upload-pack.c:	checks errno following poll() failure.
utf8.c:	checks errno following iconv() failure.
wrapper.c:
	checks errno following read(), write(), unlink(), rmdir() failure.
write_or_die.c:	checks errno following fflush(), write() failures.

Test helpers
------------
test-run-command.c:	checks errno following start_command() failure.
