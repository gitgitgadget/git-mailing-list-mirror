From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] stash: prefer --quiet over shell redirection
Date: Sat, 13 Sep 2014 14:57:59 -0700
Message-ID: <20140913215758.GA72562@gmail.com>
References: <1409470973-67707-1-git-send-email-davvid@gmail.com>
 <xmqqoaukacc3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 23:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSvKr-00019B-DZ
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 23:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbaIMV6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 17:58:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51312 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbaIMV6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 17:58:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id p10so3670089pdj.9
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9c6Q8lz4aJG6BI7c7zu6pQfwSR+JJS+62uL2coj7KvM=;
        b=uAYcMHFC7Fgl2OBrmWZfCkyEop3tIYZhI84OOpvzIhi12qggIa+/sM5IRlvfQBXaUp
         JE/ehz1+PUTO8MOdO17bpIkxMABAV36NF7kMmHqU9+XXmify9veOcBcgixDAnEmLZuHO
         HGv1iBD4xwMP+wzjePsgp7jU3kzSfNR85pOSXIE9oPpKVufHcPHOYlqAunv80abbm1YZ
         MhLECtL/8RrjBVlnU3qW0bZcZo3+EkIV+LHPlb8B40E8x7S5gDODxTKzPr58vIfaY/qg
         yKaGWp7xkiAcriDR+sZ92vWFecbTQBfh+RhXhqEseJ7Qgs8oXbJalBhLrV/BXPnq/ZO3
         ljcA==
X-Received: by 10.66.138.46 with SMTP id qn14mr24933800pab.77.1410645490705;
        Sat, 13 Sep 2014 14:58:10 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id f12sm3420921pdl.94.2014.09.13.14.58.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 14:58:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqoaukacc3.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256982>

On Fri, Sep 12, 2014 at 12:05:48PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Use `git rev-parse --verify --quiet` instead of redirecting
> > stderr to /dev/null.
> >
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> 
> Has this patch ever been tested?  t3903 seems to break with this at
> least for me.

Oops, I thought I did but it's definitely failing in pu.

The root cause is that "git rev-parse --verify --quiet" is not
actually quiet.

I'll send a patch to fix this shortly.

It touches the ref machinery, which I know Ronnie has been improving,
so I hope this doesn't cause any conflicts with other in-flight topics.


> >  git-stash.sh | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/git-stash.sh b/git-stash.sh
> > index bcc757b..2ff8b94 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -50,7 +50,7 @@ clear_stash () {
> >  	then
> >  		die "$(gettext "git stash clear with parameters is unimplemented")"
> >  	fi
> > -	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
> > +	if current=$(git rev-parse --verify --quiet $ref_stash)
> >  	then
> >  		git update-ref -d $ref_stash $current
> >  	fi
> > @@ -292,7 +292,7 @@ save_stash () {
> >  }
> >  
> >  have_stash () {
> > -	git rev-parse --verify $ref_stash >/dev/null 2>&1
> > +	git rev-parse --verify --quiet $ref_stash >/dev/null
> >  }
> >  
> >  list_stash () {
> > @@ -392,12 +392,12 @@ parse_flags_and_rev()
> >  		;;
> >  	esac
> >  
> > -	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
> > +	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
> >  		reference="$1"
> >  		die "$(eval_gettext "\$reference is not valid reference")"
> >  	}
> >  
> > -	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
> > +	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
> >  	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
> >  	s=$1 &&
> >  	w_commit=$1 &&
> > @@ -409,7 +409,7 @@ parse_flags_and_rev()
> >  	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
> >  	IS_STASH_REF=t
> >  
> > -	u_commit=$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
> > +	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
> >  	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
> >  }
> >  
> > @@ -531,7 +531,8 @@ drop_stash () {
> >  		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
> >  
> >  	# clear_stash if we just dropped the last stash entry
> > -	git rev-parse --verify "$ref_stash@{0}" >/dev/null 2>&1 || clear_stash
> > +	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
> > +	clear_stash
> >  }
> >  
> >  apply_to_branch () {

-- 
David
