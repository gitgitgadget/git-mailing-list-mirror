From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH] Add failing test: "fsck survives inflate errors"
Date: Sun, 20 Jul 2014 16:43:16 -0400
Message-ID: <87mwc37od7.fsf@naesten.mooo.com>
References: <1405831383-22477-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 22:43:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8xxN-0001qF-UH
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 22:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbaGTUn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 16:43:27 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:57971 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbaGTUnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 16:43:25 -0400
Received: by mail-qc0-f169.google.com with SMTP id m20so5073347qcx.14
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:newsgroups:to:subject:references:date:message-id:user-agent
         :cancel-lock:in-reply-to:mime-version:content-type:posted-to;
        bh=2kgQ5zarVs79+Z11RkiplMWZA8wDAAfhdVEhPtop9YI=;
        b=gkuEAbIfLBHoobxi7Z+yb1wU0C3VLsFEb6ovDyI4lzExO6zY1VoUxn1RF2n78nFrYi
         rn3yVkgFMnXnRtSxdymL/Trb6MQAiWZDRNHInNLxiqIABL+BMBZxSRSRKMgLdewnT38k
         w1wLkMXXCqMJP69WQXg/IKBsW8ccBIxN2CvbKf0WE6NNL0/p61TYJ/NcmXhKigNgr7FD
         7ta/lGNU+9U4Tnlnr9Q6WOuFxGt1ilk762nrQQxMAAhEr06rI3z14XhDyvRXadrrnTlu
         cePB2r/Ne/lXIoNsep2zqxWwrFfxpBnhrthV88AbKRhFXo1wegR2aaw8LSfRj2SFUwYu
         72Fg==
X-Received: by 10.140.26.149 with SMTP id 21mr31564551qgv.51.1405889005044;
        Sun, 20 Jul 2014 13:43:25 -0700 (PDT)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id p21sm13841470qgp.14.2014.07.20.13.43.23
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 20 Jul 2014 13:43:23 -0700 (PDT)
Received: from naesten by hydrogen with local (Exim 4.82)
	(envelope-from <naesten@gmail.com>)
	id 1X8xx2-0003Eg-Iq
	for git@vger.kernel.org; Sun, 20 Jul 2014 16:43:20 -0400
Newsgroups: gmane.comp.version-control.git
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:3qBssBTZRQA0ygEPcloore4MwN8=
In-Reply-To: <1405831383-22477-1-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Sun, 20 Jul 2014 00:43:03 -0400")
Posted-To: gmane.comp.version-control.git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253935>

The following message is a courtesy copy of an article
that has been posted to gmane.comp.version-control.git as well.

Oh, I forgot to provide any analysis of the problem.  Oops.

It may be just as well, though; I was tired enough that I might have
botched it in any case.  So, have an analysis:

While inflate errors are obviously NOT GOOD, and should perhaps be
instantly fatal for most commands, git fsck is something of a special
case because it is useful to have *it* report as many corrupt objects as
possible in one run.

Unfortunately, this is not currently the case, as shown by the provided
testcase.

The output for this testcase is:

,----
| checking known breakage:
|         hash1=ffffffffffffffffffffffffffffffffffffffff &&
|         hash2=fffffffffffffffffffffffffffffffffffffffe &&
|         mkdir -p .git/objects/ff &&
|         echo not-zlib >$(sha1_file $hash1) &&
|         test_when_finished "remove_object $hash1" &&
|         echo not-zlib >$(sha1_file $hash2) &&
|         test_when_finished "remove_object $hash2" &&
| 
|         # Return value is not documented
|         test_might_fail git fsck 2>out &&
|         cat out && echo ====== &&
|         grep "$hash1.*corrupt" out &&
|         grep "$hash2.*corrupt" out
| 
| error: inflate: data stream error (incorrect header check)
| error: unable to unpack ffffffffffffffffffffffffffffffffffffffff header
| error: inflate: data stream error (incorrect header check)
| fatal: loose object ffffffffffffffffffffffffffffffffffffffff (stored in .git/objects/ff/ffffffffffffffffffffffffffffffffffffff) is corrupt
| ======
| fatal: loose object ffffffffffffffffffffffffffffffffffffffff (stored in .git/objects/ff/ffffffffffffffffffffffffffffffffffffff) is corrupt
| not ok 5 - fsck survives inflate errors # TODO known breakage
`----

If I flip it from expect_failure to expect_success and run the test with
-i, then go into the trash directory and run "gdb ../../git-fsck", I can
obtain this (thoroughly rehearsed & trimmed) gdb transcript:

,----
| % gdb ../../git-fsck
| GNU gdb (Debian 7.7.1-3) 7.7.1
...
| Reading symbols from ../../git-fsck...done.
| (gdb) break error
| Breakpoint 1 at 0x813d24c: file usage.c, line 143.
| (gdb) break die
| Breakpoint 2 at 0x813d152: file usage.c, line 94.
| (gdb) run
| Starting program: /home/naesten/hacking/git/git-fsck
| [Thread debugging using libthread_db enabled]
| Using host libthread_db library "/lib/i386-linux-gnu/i686/cmov/libthread_db.so.1".
| Checking object directories: 100% (256/256), done.
| 
| Breakpoint 1, error (err=0x8182f7a "inflate: %s (%s)") at usage.c:143
| 143     {
| (gdb) bt
| #0  error (err=0x8182f7a "inflate: %s (%s)") at usage.c:143
| #1  0x081452ff in git_inflate (strm=0xbfffe6b8, flush=0)
|     at zlib.c:144
| #2  0x08125367 in unpack_sha1_header (stream=<optimized out>,
|     map=<optimized out>, mapsize=<optimized out>,
|     buffer=<optimized out>, bufsiz=<optimized out>)
|     at sha1_file.c:1515
| #3  0x08125546 in sha1_loose_object_info (
|     sha1=sha1@entry=0x82659d4 '\377' <repeats 20 times>,
|     oi=oi@entry=0xbfffe788) at sha1_file.c:2528
| #4  0x08126b2d in sha1_object_info_extended (
|     sha1=0x82659d4 '\377' <repeats 20 times>, oi=0xbfffe788, flags=1)
|     at sha1_file.c:2565
| #5  0x0812666f in sha1_object_info (
|     sha1=0x82659d4 '\377' <repeats 20 times>, sizep=0x0)
|     at sha1_file.c:2601
| #6  0x080f6941 in parse_object (
|     sha1=0x82659d4 '\377' <repeats 20 times>) at object.c:247
| #7  0x080758ac in fsck_sha1 (
|     sha1=sha1@entry=0x82659d4 '\377' <repeats 20 times>)
|     at builtin/fsck.c:333
...
| (gdb) c
| Continuing.
| error: inflate: data stream error (incorrect header check)
| 
| Breakpoint 1, error (err=0x817c525 "unable to unpack %s header")
|     at usage.c:143
| 143     {
| (gdb) bt
| #0  error (err=0x817c525 "unable to unpack %s header") at usage.c:143
| #1  0x08125564 in sha1_loose_object_info (
|     sha1=sha1@entry=0x82659d4 '\377' <repeats 20 times>,
|     oi=oi@entry=0xbfffe788) at sha1_file.c:2529
| #2  0x08126b2d in sha1_object_info_extended (
|     sha1=0x82659d4 '\377' <repeats 20 times>, oi=0xbfffe788, flags=1)
|     at sha1_file.c:2565
| #3  0x0812666f in sha1_object_info (
|     sha1=0x82659d4 '\377' <repeats 20 times>, sizep=0x0)
|     at sha1_file.c:2601
| #4  0x080f6941 in parse_object (
|     sha1=0x82659d4 '\377' <repeats 20 times>) at object.c:247
...
| (gdb) frame 4
| #4  0x080f6941 in parse_object (
|     sha1=0x82659d4 '\377' <repeats 20 times>) at object.c:247
| warning: Source file is more recent than executable.
| 247                  sha1_object_info(sha1, NULL) == OBJ_BLOB)) { // <-- first error
| (gdb) down
| #3  0x0812666f in sha1_object_info (
|     sha1=0x82659d4 '\377' <repeats 20 times>, sizep=0x0)
|     at sha1_file.c:2601
| 2601            if (sha1_object_info_extended(sha1, &oi, LOOKUP_REPLACE_OBJECT) < 0)
| (gdb) fin
| Run till exit from #3  0x0812666f in sha1_object_info (
|     sha1=0x82659d4 '\377' <repeats 20 times>, sizep=0x0)
|     at sha1_file.c:2601
| error: unable to unpack ffffffffffffffffffffffffffffffffffffffff header
| parse_object (sha1=0x82659d4 '\377' <repeats 20 times>)
|     at object.c:246
| 246                 (!obj && has_sha1_file(sha1) &&
| Value returned is $1 = -1
| (gdb) c
| Continuing.
| 
| Breakpoint 1, error (err=0x8182f7a "inflate: %s (%s)") at usage.c:143
| 143     {
| (gdb) bt
| #0  error (err=0x8182f7a "inflate: %s (%s)") at usage.c:143
| #1  0x081452ff in git_inflate (strm=0xbfffe710, flush=0)
|     at zlib.c:144
| #2  0x08125367 in unpack_sha1_header (stream=<optimized out>,
|     map=<optimized out>, mapsize=<optimized out>,
|     buffer=<optimized out>, bufsiz=<optimized out>)
|     at sha1_file.c:1515
| #3  0x08125429 in unpack_sha1_file (map=map@entry=0xb7fdc000,
|     mapsize=<optimized out>, type=type@entry=0xbfffe7d8,
|     size=0xbfffe7dc, sha1=0x82659d4 '\377' <repeats 20 times>)
|     at sha1_file.c:1620
| #4  0x08126024 in read_object (
|     sha1=sha1@entry=0x82659d4 '\377' <repeats 20 times>,
|     type=type@entry=0xbfffe7d8, size=size@entry=0xbfffe7dc)
|     at sha1_file.c:2667
| #5  0x08126c33 in read_sha1_file_extended (
|     sha1=0x82659d4 '\377' <repeats 20 times>, type=0xbfffe7d8,
|     size=0xbfffe7dc, flag=1) at sha1_file.c:2690
| #6  0x080f69b8 in read_sha1_file (size=0xbfffe7dc, type=0xbfffe7d8,
|     sha1=0x82659d4 '\377' <repeats 20 times>) at cache.h:853
| #7  parse_object (sha1=0x82659d4 '\377' <repeats 20 times>)
|     at object.c:256
...
| (gdb) c
| Continuing.
| error: inflate: data stream error (incorrect header check)
| 
| Breakpoint 2, die (
|     err=0x817cdbc "loose object %s (stored in %s) is corrupt")
|     at usage.c:94
| 94      {
| (gdb) bt
| #0  die (err=0x817cdbc "loose object %s (stored in %s) is corrupt")
|     at usage.c:94
| #1  0x08126cc1 in read_sha1_file_extended (
|     sha1=0x82659d4 '\377' <repeats 20 times>, type=0xbfffe7d8,
|     size=0xbfffe7dc, flag=1) at sha1_file.c:2705
| #2  0x080f69b8 in read_sha1_file (size=0xbfffe7dc, type=0xbfffe7d8,
|     sha1=0x82659d4 '\377' <repeats 20 times>) at cache.h:853
| #3  parse_object (sha1=0x82659d4 '\377' <repeats 20 times>)
|     at object.c:256
...
| (gdb) frame 3
| #3  parse_object (sha1=0x82659d4 '\377' <repeats 20 times>)
|     at object.c:256
| 256             buffer = read_sha1_file(sha1, &type, &size); // <-- death
| (gdb)
`----

It's probably clearest what's happened here if I just show you this ...

>From object.c:

--8<---------------cut here---------------start------------->8---
struct object *parse_object(const unsigned char *sha1)
{
	unsigned long size;
	enum object_type type;
	int eaten;
	const unsigned char *repl = lookup_replace_object(sha1);
	void *buffer;
	struct object *obj;

	obj = lookup_object(sha1);
	if (obj && obj->parsed)
		return obj;

	if ((obj && obj->type == OBJ_BLOB) ||
	    (!obj && has_sha1_file(sha1) &&
	     sha1_object_info(sha1, NULL) == OBJ_BLOB)) { // <-- first error
		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
			error("sha1 mismatch %s", sha1_to_hex(repl));
			return NULL;
		}
		parse_blob_buffer(lookup_blob(sha1), NULL, 0);
		return lookup_object(sha1);
	}

	buffer = read_sha1_file(sha1, &type, &size); // <-- death
	if (buffer) {
		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
			free(buffer);
			error("sha1 mismatch %s", sha1_to_hex(repl));
			return NULL;
		}

		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
		if (!eaten)
			free(buffer);
		return obj;
	}
	return NULL;
}
--8<---------------cut here---------------end--------------->8---

(I've clearly added some marginal comments to my copy. ;-)

The first two lines of output

> error: inflate: data stream error (incorrect header check)
> error: unable to unpack ffffffffffffffffffffffffffffffffffffffff header

come from deep within the call "sha1_object_info(sha1, NULL)".

The next two lines

> error: inflate: data stream error (incorrect header check)
> fatal: loose object ffffffffffffffffffffffffffffffffffffffff (stored in .git/objects/ff/ffffffffffffffffffffffffffffffffffffff) is corrupt

and death come from the call "read_sha1_file(sha1, &type, &size)", which
is fair because that's exactly what the documentation comment above
read_sha1_file_extended() *says* will happen:

--8<---------------cut here---------------start------------->8---
/*
 * This function dies on corrupt objects; the callers who want to
 * deal with them should arrange to call read_object() and give error
 * messages themselves.
 */
--8<---------------cut here---------------end--------------->8---

So, given that parse_object()'s documentation is:

--8<---------------cut here---------------start------------->8---
/*
 * Returns the object, having parsed it to find out what it is.
 *
 * Returns NULL if the object is missing or corrupt.
 */
--8<---------------cut here---------------end--------------->8---

it probably should not call read_sha1_file() on a corrupt object.

Options for fixing this would appear to include:

1. Saving the result of sha1_object_info(sha1, NULL) to a variable and
   returning early if the object is corrupt.  (But what happens if there
   is corruption far enough in that it isn't seen when trying to grab
   the object header?)

2. Calling read_object() and giving our own error messages.

3. Making read_sha1_file_extended only *optionally* die; since it's
   calling die() directly.

I'm also a bit nervous about this, though:

--8<---------------cut here---------------start------------->8---
static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
{
	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
}
--8<---------------cut here---------------end--------------->8---

Do we really want that happening while scanning the loose objects?

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
