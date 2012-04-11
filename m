From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: stash refuses to pop
Date: Wed, 11 Apr 2012 09:15:57 +0200
Message-ID: <CAA5Ydx9CTKdm-3OPM1s424d=PAi18MtpfhNXxdDw=44VQBXtGQ@mail.gmail.com>
References: <4F847350.3000409@ubuntu.com>
	<7vpqbfpim2.fsf@alter.siamese.dyndns.org>
	<4F84827B.80104@ubuntu.com>
	<CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phillip Susi <psusi@ubuntu.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 09:16:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHrmf-00061B-4O
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 09:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab2DKHP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 03:15:59 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41628 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab2DKHP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 03:15:58 -0400
Received: by eekc41 with SMTP id c41so118535eek.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KqhWBQgFppM9C0LWp5eQl6laZe8JMTI+yVM+iLqC6Bc=;
        b=szW+V/+qxre58eNMME/5JCD+DvqX4rtLuEONFcL6/bjLDha08AVXxiSgbYU0UunDZ+
         v29/kg/vnHGFF3PrTqwc5fQZADdMJBRG0mbs6TgKCVDJfmqCc/f4Cvd/CM2saXtVZYDX
         3Jpgj9SUzqTAGyPvPD08FjQYJ6LADjITcnVqZegSgUI/BVnsHXzxyw+/NfOm02ahEUXi
         O93nI1xCK1aa4+we6rIrSeVME2ZR0pptWLdCSCp5LEYFKQBtk0IAfLUf+M6yTiMcGwCw
         JcHbW4zaXve08qZF60vQtSxOBO/jKt7LdYqW2FH617i7iR5/djWDBVIMR/0OtZ9DNQCb
         QfsA==
Received: by 10.14.51.207 with SMTP id b55mr1747725eec.53.1334128557239; Wed,
 11 Apr 2012 00:15:57 -0700 (PDT)
Received: by 10.213.3.136 with HTTP; Wed, 11 Apr 2012 00:15:57 -0700 (PDT)
In-Reply-To: <CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195153>

On Wed, Apr 11, 2012 at 4:47 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>
> On 11 April 2012 04:56, Phillip Susi <psusi@ubuntu.com> wrote:
> > On 4/10/2012 2:05 PM, Junio C Hamano wrote:
> >> So probably the right way to use "stash -p" (if there were such a thing)
> >> would be to stash away the remainder in a separate stash with another
> >> "stash" without "-p" (which will clear your workspace to a pristine state)
> >> and then pop the one you created with "stash -p", I think.
> >
> > That would not get you back to the state you were in when you first stashed,
> > but instead to a state where you have the first set of changes, but not the
> > second ( which you then also can not pop due to the first changes being
> > there ).
>
> The first question, it would seem, is what should git do when there
> are modified files present, and the user tries to pop a stash which
> touches those files. The current behaviour is to reject the pop,
> reasonable enough, though for what exact reason I am not sure
> (potential merge issues, I assume).
>
> The method you have described is just one way of coming on this
> situation. The user could have
> * stashed their work, modified some files and tried to pop
> * partially stashed their work, and tried to pop
> * partially stashed their work, modified some files and then tried to pop.
>
> The options for dealing with this situation seem to be
> 1. Reject the pop outright
> 2. put the affected files into a merge conflict state
> 3. revert the file to the state they were at at the time of stash
> 4. reject those files that do not apply cleanly (but apply all others)
> 5. reject those hunks which do not apply cleanly (but apply all others)
> 6. provide an interactive pop session for choosing what to apply

#2 seems like the most natural option, for the reason Phillip Susi
mentioned. But how about
7. Apply all hunks iff all of them can be applied cleanly
? That way pop would be an atomic operation. It might be easier to do
than 2, and even if 2 is implemented it would be nice to have a
--atomic or --dry-run option when you want to make sure not to end up
in a messy merge.

Cheers,
V
