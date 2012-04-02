From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Sun, 1 Apr 2012 20:13:54 -0400
Message-ID: <20120402001354.GA12651@padd.com>
References: <20120401225407.GA12127@padd.com>
 <20120401231259.GE20883@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 02:14:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEUuK-00060K-FK
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 02:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab2DBAN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 20:13:58 -0400
Received: from honk.padd.com ([74.3.171.149]:34110 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713Ab2DBAN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 20:13:58 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 3D0751E66;
	Sun,  1 Apr 2012 17:13:57 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D951C313EC; Sun,  1 Apr 2012 20:13:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120401231259.GE20883@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194495>

jrnieder@gmail.com wrote on Sun, 01 Apr 2012 18:12 -0500:
> Hi Pete,
> 
> Pete Wyckoff wrote:
> 
> >     from :1M 100644 :103 hello.c
> >
> > It is missing a newline and should be:
> >
> >     from :1
> >     M 100644 :103 hello.c
> 
> Good idea; thanks.
> 
> I agree that this at least deserves a warning and probably should
> error out.
> 
> [...]
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -2537,8 +2537,16 @@ static int parse_from(struct branch *b)
> >  		hashcpy(b->branch_tree.versions[0].sha1, t);
> >  		hashcpy(b->branch_tree.versions[1].sha1, t);
> >  	} else if (*from == ':') {
> > -		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
> > -		struct object_entry *oe = find_mark(idnum);
> > +		char *eptr;
> > +		uintmax_t idnum = strtoumax(from + 1, &eptr, 10);
> > +		struct object_entry *oe;
> > +		if (eptr) {
> > +			for (; *eptr && isspace(*eptr); eptr++) ;
> > +			if (*eptr)
> > +				die("Garbage after mark: %s",
> 
> The implementation seems more complicated than it needs to be.  Why
> allow whitespace after the mark number?

Fear of breaking existing fast-import users that might happen
to have stray whitespace, or \r\n terminators.

Other similar fast-import are less forgiving, such as
parse_cat_blob.  Maybe we should generalize and enforce its
approach to parsing marks.

		-- Pete
