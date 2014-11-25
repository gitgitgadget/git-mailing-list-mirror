From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 22:21:56 +0100
Message-ID: <CAP8UFD0WcSM4NP8XHQe5pg0bwC5-C19OdcNoPWFFz7Ngrfbg8g@mail.gmail.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
	<CAP8UFD0+Ef9JbbkZ+LBHcD6DVZiMGxFdrMnjLEViHHMERY5wuw@mail.gmail.com>
	<5474B5EE.1030406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paolo Bonzini <bonzini@gnu.org>, git <git@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 22:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtNYg-0001yk-K9
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 22:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbaKYVV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 16:21:58 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46039 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKYVV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 16:21:57 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1421678ieb.21
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 13:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oEDYNVDlCwaZfqwvDBkb3exQqJvCJ7Zj0uJWlufHXlM=;
        b=NR1NwV1OPsJ9bGdl2eLg2idMXV+gTYQFCbyI+JFVO/6gviRX2qlyCGjDlx6HebeA1A
         d4T5KdLoTCZB9f+1nfNV2VL0yVzYmbZSkBDXPu0EA9gyi/NJZ928/qIzBZz6jG0NLOEq
         EARaxtLN55/2sQ6+HRp6systm4ibZ6J4lNqC2vBZ7zt66/kkrnDtRBBDUiaixneUJdaV
         tsk/4mP96Qr1Aih0QuhFx1FpibDVhGuNVDz4+joKzZepQfYK0LrI8jxMFQUz6DMk9Gls
         JX9CemRpPKMDVcT7SJN7apr8snCVwjmN5QK1ODGczfO9cSyovLWO5lTux4nX1qwnVKLO
         1FLg==
X-Received: by 10.51.17.73 with SMTP id gc9mr19462991igd.24.1416950516870;
 Tue, 25 Nov 2014 13:21:56 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Tue, 25 Nov 2014 13:21:56 -0800 (PST)
In-Reply-To: <5474B5EE.1030406@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260242>

On Tue, Nov 25, 2014 at 6:01 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 25/11/2014 17:27, Christian Couder wrote:
>>> > From: Paolo Bonzini <pbonzini@redhat.com>
>>> >
>>> > This series adds a --message-id option to git-mailinfo and git-am.
>>> > git-am also gets an am.messageid configuration key to set the default,
>>> > and a --no-message-id option to override the configuration key.
>>> > (I'm not sure of the usefulness of a mailinfo.messageid option, so
>>> > I left it out; this follows the example of -k instead of --scissors).
>>> >
>>> > This option can be useful in order to associate commit messages with
>>> > mailing list discussions.
>>> >
>>> > If both --message-id and -s are specified, the Signed-off-by goes
>>> > last.  This is coming out more or less naturally out of the git-am
>>> > implementation, but is also tested in t4150-am.sh.
>> Did you have a look at git interpret-trailers currently in master?
>
> Hmm, now I have.
>
> As far as I understand, all the git-am hooks are called on the commit
> rather than the incoming email: all headers are lost by the time
> git-mailinfo exits, including the Message-Id.  And you cannot call any
> hook before git-mailinfo because git-mailinfo is where the
> Content-Transfer-Encoding is processed.
>
> How would you integrate git-interpret-trailers in git-mailinfo?

I don't know exactly, but people may want to add trailers when they
run git-am, see:

http://thread.gmane.org/gmane.comp.version-control.git/251412/

and we decided that it was better to let something like git
interpret-trailers decide how they should be handled.

Maybe if git-interpret-trailers could be called from git-mailinfo with
some arguments coming from git-am, it could be configured with
something like:

git config trailer.Message-Id.command 'perl -ne '\''print $1 if
m/^Message-Id: (.*)$/'\'' $ARG'

So "git am --trailer 'Message-Id: msg-file' msg-file" would call "git
mailinfo ..." that would call "git interpret-trailers --trailer
'Message-Id: msg-file'" that would call "perl -ne 'print $1 if
m/^Message-Id: (.*)$/' msg-file" and the output of this command, let's
call it $id, would be put into a "Message-Id: $id" trailer in the
commit message.

This way there is nothing specific to Message-Id in the code and
people can decide using other trailer.Message-Id.* config variables
exactly where the Message-Id trailer would be in the commit message.

Best,
Christian.
