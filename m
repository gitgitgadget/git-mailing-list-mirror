From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 14:36:19 -0400
Organization: Twitter
Message-ID: <1431455779.16652.20.camel@ubuntu>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	 <1431384645-17276-4-git-send-email-dturner@twopensource.com>
	 <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsF2Z-0007po-DO
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 20:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbbELSgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 14:36:23 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35490 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916AbbELSgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 14:36:22 -0400
Received: by qgej70 with SMTP id j70so9144682qge.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 11:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=5bIAsJ6VHwTIBjSYF6fVsay+eGHPJIbuJgv0s4pk4Ik=;
        b=UFNyK4kptOXvT8C4jF2n5YIF0sX4qPomHmRlJVKr5DRoylv9JOXANwNa1ath6aBeUf
         aZC0ILk9LnOl1nSmsIfNsSxTYG1KdNaGITfd/pKCNIToHYhcL+f5s8ZQGyeJHn4DciHB
         crAnz6TqQqTCLxRHhjlqGbOWq+WWv60BtuyClg7jFshMfVCWqdj+cfvAtD367JCHxG4W
         i1Bp6jss/ijucQf5uxIVZ6ydjn610Kjufq61Uqvt+NKjS39edw6RvJGDIQ03qrhFf47C
         kfHbynNYXroE2hkZhMrvFD0um0t1GmyoXzuPF4SQIC92l7pmN7TvxosTYRciWNPdTQIz
         mbvQ==
X-Gm-Message-State: ALoCoQllYwZuoQ3mGV5qIcPz6wOu3BF+7+Jn2iyPCH+/XShgSR6XXPFgteVnXeNBbSEpk0uYVskv
X-Received: by 10.229.37.200 with SMTP id y8mr22808008qcd.28.1431455781652;
        Tue, 12 May 2015 11:36:21 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id n62sm13934348qge.27.2015.05.12.11.36.20
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 11:36:20 -0700 (PDT)
In-Reply-To: <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268868>

On Tue, 2015-05-12 at 11:07 -0700, Junio C Hamano wrote:
> > +	Both plink and alink point outside the tree, so they would
> > +	respectively print:
> > +	symlink 4
> > +	../f
> > +
> > +	symlink 11
> > +	/etc/passwd
> > +
> > +
> > +
> 
> A few points I noticed:
> 
>  * It is not clear that this is (currently) only for --batch and
>    --batch-check until you read four lines into the description.
> 
>    Perhaps start the description like this instead?
> 
>    --follow-symlinks::
>            When answering `--batch` or `--batch-check` request,
>            follow symlinks inside the repository when requesting objects
>            with extended SHA-1 expressions of the form tree-ish:path-in-tree.

Will rearrange.

>    Also I'd lose the "This option requires ..." sentence in the middle
>    (I'll come back to the reason why later).
> 
>  * Is it fundamental that this is only for --batch family, or is it
>    just lack of need by the current implementor and implementation?
>    "git cat-file --follow-symlinks blob :RelNotes" does not sound
>    a nonsense request to me.

The reason that --follow-symlinks doesn't work for non-batch requests is
that it is impossible to distinguish out-of-tree symlinks from valid
output in non-batch output. I will add text explaining this. 

>  * I am not sure if HEAD:link that points at HEAD:link should be
>    reported as "missing".  It may be better to report the original
>    without any dereferencing just like a link that points at outside
>    the tree? i.e. "symlink 4 LF link".

Unfortunately, a symlink loop might include relative symlinks
(e.g. ../a).  If we return a relative symlink, the user will
not be able to distinguish it from a non-loop, out-of-tree symlink.  So
I think we may not return symlink 4 LF ../a for these cases.  

We could, I guess, have a separate output like loop <size> LF link
<LF>", but, unless we always save and output the first link in the
chain, we won't know what any link is relative to.  Since reasonable
people do not create symlink loops, and since there are other mechanisms
for symlink loop debugging (e.g. plain cat-file), I think it is OK not
to put special effort into handling loops.

>  * I think "echo :RelNotes | git cat-file --batch --follow-symlinks"
>    that does not follow a symlink is a BUG.  Unless there is
>    something fundamental that in-index object should never support
>    this feature, that is.  But I do not think of a good reason
>    why---it feels that this is just the lack of implementation that
>    can be addressed by somebody else in the future who finds the
>    need for the support.

Yes, this should definitely be addressed in the future.  I didn't see a
straightforward way to generalize this code to also address the index,
so a new version of this function would have to be written.  That's why
I didn't add that feature yet.  The lack of it is definitely a bug,
though.  

>         Also the option does not (currently) work correctly when an
> 	object in the index is specified (e.g. `:link` instead of
> 	`HEAD:link`) rather than one in the tree.
> 
> We need to also say something about the "missing" vs "loop" case, if
> we choose to leave that part broken.  I'd rather see it fixed, but
> that is not a very strong preference.

Will add an example.

> By the way, the text after your patch would not format well thru
> AsciiDoc.  See attached for a suggested mark-up fix that can be
> squashed.

I'll squash that in when I re-roll.  Thanks for the formatting.
