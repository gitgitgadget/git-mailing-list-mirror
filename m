From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --follow-symlinks to --batch
Date: Mon, 11 May 2015 15:39:46 -0700
Message-ID: <xmqqtwvi20y5.fsf@gitster.dls.corp.google.com>
References: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
	<1431366989-7405-4-git-send-email-dturner@twopensource.com>
	<xmqqd2263lxf.fsf@gitster.dls.corp.google.com>
	<1431383471.15048.9.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 12 00:39:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrwMc-0002ny-8E
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 00:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbEKWjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 18:39:49 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:33101 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbEKWjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 18:39:49 -0400
Received: by yhcb70 with SMTP id b70so40523059yhc.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=60EFkwtQlH3KLLdHYDSAk2vw+fV2gjjtny4KY+mevO8=;
        b=Exl4BEpcUjd0C8MCsISxSPDd41gWVY3ohDcI4F+IaJqNzlLVI6AnOPqLedYuJG40pv
         IW6SnmzJPtp65CZpu5JU5Z6lIc1sYM/IkzTHGveKfIokTnLojMpKTLK1pz6gd27hSPTP
         jQISMC+s5bZ8KKsZpAb4/e3Emp0fZLWuHcRnue/UZxxim64Qeh+Z7Xb3haKFvVyymHVM
         ilE4emyPB68Xz3pZKsAFial1RW3DKw5x2s2r4oGzmsrRYgWMPrCGEYHb49MJJ6mnucRn
         7rwrzbJ38YEx9tFqF8zotEPAftuqiys2J9owixh+577tGYVSDfCdGn/kE7xSVASXhfrO
         e6Gg==
X-Received: by 10.236.36.108 with SMTP id v72mr12457027yha.74.1431383988599;
        Mon, 11 May 2015 15:39:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id d45sm13390205yhd.10.2015.05.11.15.39.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 15:39:47 -0700 (PDT)
In-Reply-To: <1431383471.15048.9.camel@ubuntu> (David Turner's message of
	"Mon, 11 May 2015 18:31:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268827>

David Turner <dturner@twopensource.com> writes:

> I'll send something like this when I re-roll:
>
> Follow symlinks inside the repository when requesting objects with
> extended SHA-1 expressions of the form tree-ish:path-in-tree. Instead of
> providing output about the link itself, provide output about the
> linked-to object.  This option requires --batch or	--batch-check.  In
> the event of a symlink loop (or more than 40 symlinks in a symlink
> resolution chain), the file will be treated as missing.  If a symlink
> points outside the tree-ish (e.g. a link to /foo or a root-level link
> to ../foo), the portion of the link which is outside the tree will be
> printed. Follow-symlinks will be silently turned off if <object>
> specifies an object in the index rather than one in the object database.

Very understandable. I like it.

>
> I could also provide some examples, if you think this would be useful.

That may not be a bad idea.

>> > +symlink SP <size> LF <symlink> LF
>> > +------------
>> 
>> A symlink contain LF, obviously, and we should use some quoting
>> convention.  Perhaps quote_c_style() on a string that needs it is
>> sufficient---most sane people do not put LF or literally '\' 'n' or
>> '"' in their symbolic links, so the ugly output is not visible for
>> them, and it is far better to be able to say "If you have funny
>> characters in your symlinks, they will be quoted" than "If you have
>> funny characters in your symlinks, you are SOL".
>> 
> There is no need for quoting because <size> is sufficient to
> disambiguate the parsing (just as is the case for blobs, which might
> contain arbitrary characters).

OK.  That is a very sensible way to think about it.

I briefly wondered if trailing LF is a healthy thing, but blob
output also gives an extra LF after <contents> (i.e. the reader of
"<name> SP blob SP <size> LF <contents> LF" must skip (size + 1)
bytes to get to the next record), so it is consistent.

Thanks.
