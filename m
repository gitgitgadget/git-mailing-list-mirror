From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb.cgi: Use File::MMagic; "a=blob" action knows the blob/file type
Date: Sat, 8 Jul 2006 18:17:56 -0700 (PDT)
Message-ID: <20060709011756.92415.qmail@web31815.mail.mud.yahoo.com>
References: <7vzmfksjpe.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 03:18:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzNvu-0003Yy-Ei
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 03:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWGIBR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 21:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWGIBR5
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 21:17:57 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:1433 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161030AbWGIBR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 21:17:57 -0400
Received: (qmail 92417 invoked by uid 60001); 9 Jul 2006 01:17:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fTXG9B2SBUvw+4NPNZMt71/lFQ7TjUqbFYQz7qot4LwNaCQax5z0l0+hwSHFcjLFPG+eqNH9OqqZLLEx1epJMftuLUYMRkyV/Tj3Ph9WxbFpo/Udb1vdiMDbugQ9kTsfrsV16Qnc8nNr3q9BofMVz0Xgb6gu/XDQDY4oyiTq464=  ;
Received: from [68.186.48.129] by web31815.mail.mud.yahoo.com via HTTP; Sat, 08 Jul 2006 18:17:56 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmfksjpe.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23518>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Use File::MMagic to determine the MIME type of a blob/file.
> > The variable magic_mime_file holds the location of the
> > "magic.mime" file, usually "/usr/share/file/magic.mime".
> > If not defined, the magic numbers internally stored in the
> > File::MMagic module are used.
> 
> I am sorry to ask you this, but would you mind redoing this
> patch without File::MMagic bits?

Yeah, no problem, will do.

> I think giving "a=blob" an
> ability to automatically switch to git_blob_plain is a good
> addition (as is your earlier patch to give a direct link to
> reach blob_plain from the list), so let's have that part in
> first.

Ok.

> I haven't applied your earlier one but it will appear in
> "next" shortly.

Ok.

> Existing filename based mimetypes_guess should be a lot cheaper
> than exploding a blob and feeding it to File::MMagic.  I was
> hoping File::MMagic to be used when we cannot guess the content
> type that way (i.e. when mimetypes_guess returns undef or
> application/octet-stream).

The MIME guessing is used in git_blob_plain(), where the blob
is already exploded, since a file descriptor is passed to the MIME
guessing routines.

Initially I tried using the already opened file descriptor to
the blob, but File::MMagic v1.27 always returns "text/plain"
on that.  I was astounded by this and a 5 line perl script
using that same module confirmed my suspicion that the module
or "seek" is broken in perl or in FileHandle.  I.e.
checktype_filename() succeeds, but checktype_filehandle()
always returns "text/plain".

Had simply reading the file descriptor succeeded, then we'd not
need to explode blobs in $git_temp.

The other reason I decided to completely go with File::MMagic is
that if I'm going to use it to decide the mime type after
the default method didn't succeed, why not forget the default
method and just use File::MMagic in general -- seemed like a logical
simplification.

> Since the repository owner can correct misidentification by the
> standard /etc/mime.types by supplying a custom per-repository
> $mimetypes_file (modulo that the current implementation of
> mimetype_guess_file does not allow it if the file does not have
> an extension that is specific enough), File::MMagic might be an
> overkill, especially if used in the way this patch does.  To
> allow finer grained differentiation that cannot be done with
> file extensions alone (e.g. some files may have .dat extension
> but one can be VCD mpeg wrapped in RIFF, and another can be a
> Z-machine story file), it might be simpler to allow the
> repository owner to specify full $file_name for such an ambiguous
> file in their custom $mimetypes_file, and try to match it in
> mimetype_guess_file sub.  That way we may not even need to use
> File::MMagic.

This is true, but I wonder how many people are going to go and
create their own mime.type files.  Most of the time people would
do minimal gitweb.cgi changes not even specifying $mimetypes_file
nor even $magic_mime_file.

> Are there cases where only $hash is given without $file_name?
> If so we may need to fall back on File::MMagic in such a case
> after all, but get_blob_mimetype sub copies the whole blob to a
> temporary file to work around a problem with version 1.27 you
> state in the comment -- this is way too much (and nobody seems
> to clean up the tempfile).  Looking at magic.mime, I suspect we
> might be able to get away with the first 4k bytes or so at most
> (the largest offset except iso9660 image is "Biff5" appearing at
> 2114 to signal an Excel spreadsheet).

I was hoping that tmpwatch(8) would clean up the blobs in Linux/UNIX.
But we can also delete them after the lookup.  Anothing thing is that
getting a blob isn't that often and when it happens, after the MIME
lookup it is already in the pagecache.

    Luben
