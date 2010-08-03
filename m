From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Tue, 3 Aug 2010 19:56:42 -0400
Message-ID: <AANLkTim=avirVOZ99_Pgp1iLJQ_5J_1xpAad84boi_M3@mail.gmail.com>
References: <i308gl$v6p$1@dough.gmane.org>
	<20100731044957.GA8920@burratino>
	<i30bg7$50k$1@dough.gmane.org>
	<20100731054437.GD14425@burratino>
	<i30g2s$dpt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 01:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgRLm-00021c-06
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 01:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885Ab0HCX4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 19:56:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56409 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab0HCX4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 19:56:43 -0400
Received: by iwn7 with SMTP id 7so5552621iwn.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=MyUWFAOM/s6Hx4n2WHJhu6DG1jFfy74KVoB9XTmW77o=;
        b=I+xn+ZN6DbYkgRNHZSuk+kxhjFROVRxad5I7uSweuNn6FNjMhPk1Qy59i+dGvs2JSg
         ycPNhCVB+HTVaiUxqqSt3yBWenfM12e46/vvqN6CYe27Ys+zQPC3y8gcvgFa2RqbTKkq
         bODTw3usk5e11f+6YjxbvAdUYywaAtFD499yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FeZ9l1taBCDaFtIRuWkrrhvrm2UDVuHfbNEzmYjSkItoL8YHAlvogWlccLFyOeNTQW
         nCdUzfGfkb3ETR+pxdaqv1e52SzamKekPwn81kzuNOz3CHZZDnw50qJq5MqXz3rUd1Tk
         91gKjL17bx+m4mkydRl1NscQfdctvrVuMAStc=
Received: by 10.231.149.207 with SMTP id u15mr9679177ibv.13.1280879802920; 
	Tue, 03 Aug 2010 16:56:42 -0700 (PDT)
Received: by 10.231.155.74 with HTTP; Tue, 3 Aug 2010 16:56:42 -0700 (PDT)
In-Reply-To: <i30g2s$dpt$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152549>

On Sat, Jul 31, 2010 at 2:32 AM, Walter Bright <boost@digitalmars.com> wrote:
> So I'm lost again. If the version in the repository is always converted to
> LF, then why do I need to set autocrlf=input ?

Let's start over. :-)

Before git-1.7.2, EOL conversion was rather insane. It's fixed in
1.7.2, so I'm going to start by explaining what happens with that
version and later.

Option 1 (text/eol attributes):

- Normally git will perform no EOL conversion. Files are committed
into the repo exactly as you see them in your checkout.

- To have git perform EOL conversion, you need to either explicitly
tell it which files are text, or let it autodetect. You normally do
this via the .gitattributes file using:

  <pattern> text

or

  * text=auto

In the former case, you're telling git explicitly which files are
text. In the latter case, you're telling git to do its best to detect
which files are text.

Files which are explicitly tagged as text, or auto-detected as text,
will have their EOLs converted to LF on check-in, and converted to
core.eol on check-out. core.eol defaults to "native" which means LF on
Unix and CRLF on Cygwin, but you can explicitly set it to "lf" or
"crlf" if you desire.

Certain files you may wish to specify their EOL in the working copy
explicitly. You do this with the eol attribute. e.g.:

  <pattern> eol=crlf
  <pattern> eol=lf

Files which are tagged with eol={crlf,lf} are implicitly text, and
will have their EOLs converted to LF on check-in, and converted to the
specified EOL on check-out.

Okay, so that's how you ensure that certain files have LFs in the
repo, and the desired EOL in the working-copy.

Option 2 (core.autocrlf):

With core.autocrlf=true, any files in the repo that git detects as
text and which already have LF EOLs will have their EOLs converted to
CRLF on check-out. Also, any additions to these files, or any new
files that git detects as text, will have their EOLs converted to LF
on check-in.

In this way, core.autocrlf=true is similar to "* text=auto", however
it does not affect any files in the repo which already have CRLF EOLs.

AFAIK, there's no reason to set core.autocrlf=true on Unix. You'd
typically only set it under Windows.

I'm going to stop here as I think these are the only options that make
sense with 1.7.2 and above. If you want me to explain your options
using earlier versions of git, I can try, but it's even more
confusing.

j.
