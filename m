From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/18] (trivial) notes.h: Minor documentation fixes to
 copy_notes()
Date: Tue, 5 Oct 2010 09:55:43 -0500
Message-ID: <20101005145543.GD12797@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 16:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P38z2-0000q6-J6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 16:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab0JEO7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 10:59:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41113 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab0JEO7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 10:59:04 -0400
Received: by fxm4 with SMTP id 4so442452fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PORisPW5da0nMTTWoEmIZUyaoDd8M3JTPx3uS85qDCI=;
        b=x2nIFfSJ6CaUxlj4oR/dnjgFy9mYOU/dYEXQQObjcNK+mWapEuZHw/GPcZuYYMdNcZ
         kgse3xdCt+StKuGoScoFWxhDYpgqUAAdmNGw5hY+C2cWcw99fLbAyBOSiqJoZrlo+nAF
         WtIlqX44B7hcmDAWsYl49jqc1noZy4th5SMug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xk3b0U1cXOKY206TbZc3z/XP6etdBd4XmTrvwXytFLK0jI5bNY25lEuToY074m5qoX
         E7quDJh+umpAR4CBrrEdGD/j83N9efY1nAkRSyf1a2y93U7Fa1LvpRWgKBP3APghakIp
         7Sd1DswQ6QwDxiBrzS/TjZGU9guHp2vqs4f8U=
Received: by 10.223.121.201 with SMTP id i9mr410485far.102.1286290743755;
        Tue, 05 Oct 2010 07:59:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a16sm2926157fai.25.2010.10.05.07.59.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 07:59:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285719811-10871-2-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158199>

Johan Herland wrote:

> --- a/notes.h
> +++ b/notes.h
> @@ -104,6 +104,10 @@ const unsigned char *get_note(struct notes_tree *t,
>   * Copy a note from one object to another in the given notes_tree.
>   *
>   * Fails if the to_obj already has a note unless 'force' is true.
> + *
> + * IMPORTANT: The changes made by copy_note() to the given notes_tree structure
> + * are not persistent until a subsequent call to write_notes_tree() returns
> + * zero.

This reminds me: I sometimes wish there were a
Documentation/technical/api-notes.txt giving a high-level overview of
the API, something like this to start (warning: formatting probably
broken):

-- 8< --
notes API
=========

So you want to write or access persistent, per-object text?  The notes
API might help.

Calling sequence
----------------

The caller:

* Allocates and clears a `struct notes_tree`, then fills it based on a
  new or existing notes ref with `init_notes()`.

* Adds, removes, and retrieves notes as desired:

  . To add notes: use `write_sha1_file()` to create a blob object
    containing the information to be stored, and add it to the
    in-core notes tree with `add_note()`.

  . Retrieve notes as blob objects with `get_note()`, or as
    text with `format_note()`.

  . Change which objects a note is attached to with `copy_note()`
    and `remove_note()`.

* Can iterate over all notes with `for_each_note()`.

* Can remove notes attached to missing objects with `prune_notes()`.

* (Optionally) makes changes persist with `write_notes_tree()`.

* Frees resources associated to the notes tree with `free_notes()`.

A program like 'git log' that needs to find the notes corresponding
to certain objects in multiple notes trees might instead use the
display notes API.  In this case, the caller:

* (Optionally) prepares a `struct display_notes_opt` with settings
  about which notes trees to use.

* Initializes the display notes machinery with `init_display_notes()`.

* Retrieves notes for each object of interest with
  `format_display_notes()`.
-- >8 --
