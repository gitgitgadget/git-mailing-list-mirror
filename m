From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 13:22:15 -0700
Message-ID: <xmqqd225fsw8.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
	<xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
	<1431456922.16652.26.camel@ubuntu>
	<xmqqlhgtftw0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:22:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsGh9-0004xB-E8
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 22:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbbELUWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 16:22:20 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33193 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbbELUWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 16:22:17 -0400
Received: by iebgx4 with SMTP id gx4so12733683ieb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=thwSGrBzW9GO2o2IyVeGhjzweOWdt7MH/8bfZY7yvfc=;
        b=dDtZed4RoOTCs090ohI3Tsng+ylg/zMnmrPXPR4BqjE814IV0/oVygyhG2PiF/ZBZP
         /PmnN+mbToYfq82cyrzHoZ4+rnfmz7pCy62D69xu3a8h608n0oBttEzPMk/WHaK+vXnf
         Hr7hJFX6xFwSZNHpKYeXcFq6x71uiyX2cgryjDf8gLeG791EsrNfaJkJSIH/cvQWY2Oe
         qlPbU9CaEj54QB/Sytn8GOJtoszWJUC2trxxGLtxchtnPeJ2EL3Grf6HfEoR9GBhDpTW
         HMtHmllaWJvOKaGOBgXpsKObSEeHOo5858TohVSFEMP4ixoJQh9abJdhY4bhAnVAmHkS
         rXfg==
X-Received: by 10.50.98.73 with SMTP id eg9mr3665335igb.10.1431462137270;
        Tue, 12 May 2015 13:22:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id o15sm1939157igw.11.2015.05.12.13.22.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 13:22:16 -0700 (PDT)
In-Reply-To: <xmqqlhgtftw0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 May 2015 13:00:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268879>

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, that would also give us "missing", so in that sense you are
> being consistent.
>
> But I do not think that consistency is useful.  Showing just
> "missing" instead is losing information and that is what bothers me.
>
> Showing "symlink 6 nosuch" to this "link points at a target that
> would be in-tree but there is no such object in the tree" symbolic
> link instead of "missing" would make it more useful, and I do not
> offhand think of a downside, but maybe I am missing something.
>
> For a link that points outside, the code already gives
>
>     $ ln -s ../outside outlink
>     $ git add outlink
>     $ echo "$(git write-tree):outlink" |
>       git cat-file --batch --follow-symlinks
>
> "symlink ../outside", so the script reading from the batch output
> already has to be prepared to handle "symlink" and understand it as
> saying "the link does not point an object that is inside the tree".

Having said all that, I think we can make readers' life easier by
classifying various reasons why --follow-symlinks cannot pretend
as if the in-tree pointee were given as its input and signal it
differently:

 * A link points outside the original tree (or the index, once we
   support "cat-file :RelNotes").

   I think your "symlink <size> LF <target> LF" already does this.

 * A link points (directly or indirectly) at itself.

   This would be your "loop <size> LF <target> LF", which I think is
   good.

 * A link does not step outside the original tree, but the pointee
   does not exist in the original tree.

   I think you currently say "<object name for HEAD:link> missing",
   but I do not think it is useful.  That object does exist, but it
   merely cannot be dereferenced.  Perhaps introducing a new one,
   e.g. "dangling <size> LF <target> LF" similar to symlink/loop,
   would help the reader better?

Are there other cases?  The only other case I think of is when the
link resolves cleanly inside the tree, which you already handle.

Thanks.
