From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 2/2] fast-import: tighten parsing of mark references
Date: Tue, 3 Apr 2012 21:20:37 -0400
Message-ID: <20120404012037.GB4124@padd.com>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <1333417910-17955-3-git-send-email-pw@padd.com>
 <20120403142001.GD15589@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 03:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFEtz-0004NM-Vx
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 03:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257Ab2DDBUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 21:20:42 -0400
Received: from honk.padd.com ([74.3.171.149]:36607 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818Ab2DDBUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 21:20:42 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id C209024F4;
	Tue,  3 Apr 2012 18:20:40 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A984B313CD; Tue,  3 Apr 2012 21:20:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120403142001.GD15589@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194675>

jrnieder@gmail.com wrote on Tue, 03 Apr 2012 09:20 -0500:
> (cc-ing Johan for noteimport code)

Thanks, glad you noticed.

> Pete Wyckoff wrote:
> [...]
> > +++ b/fast-import.c
> [...]
> > @@ -2236,20 +2287,24 @@ static void file_change_m(struct branch *b)
> >  
> >  	if (*p == ':') {
> >  		char *x;
> > -		oe = find_mark(strtoumax(p + 1, &x, 10));
> > +		oe = find_mark(parse_mark_ref_space(p, &x));
> >  		hashcpy(sha1, oe->idx.sha1);
> >  		p = x;
> 
> Simpler:
> 
> 	if (*p == ':') {
> 		oe = find_mark(parse_mark_ref_space(p, &p));
> 		hashcpy(sha1, oe->idx.sha1);
> 	} else if ...

Yes.  I thought about just passing in plain old &p.  Even though
these approaches would work, it is a bit more difficult for
novice C coders to read.  Figured we should err on the side of
helping future code readers.  I can add more cleverness if you
feel strongly.

> >  	} else if (!prefixcmp(p, "inline")) {
> >  		inline_data = 1;
> >  		p += 6;
> > +		if (*p != ' ')
> > +			die("Missing space after 'inline': %s",
> > +			    command_buf.buf);
> >  	} else {
> >  		if (get_sha1_hex(p, sha1))
> >  			die("Invalid SHA1: %s", command_buf.buf);
> 
> If I write
> 
> 	M 100644 inliness some/path/to/file
> 
> was my mistake actually leaving out a space after 'inline' or
> was it using an invalid <dataref>?
> 
> I think the latter, so I would suggest
> 
> 	} else if (!prefixcmp(p, "inline ")) {
> 		inline_data = 1;
> 		p += strlen("inline");	/* advance to space */
> 	} else {
> 		if (get_sha1_hex(p, sha1))
> 			...

Insead of "Missing space after 'inline'", you'll get "Invalid
SHA1".  You misspelled "inline" with "inliness"?  And would
prefer to be told you provided an invalid SHA1?

I'm tempted to guess that any string starting with "inline", e.g.
"inlinePath/To/File" without a space is still a good indication
that they were trying to say "inline ".  The chance that they
horribly typed a SHA1, or really had a path staring with "inline"
and forgot the dataref entirely, feel less likely.

> [...]
> >  	}
> > -	if (*p++ != ' ')
> > -		die("Missing space after SHA1: %s", command_buf.buf);
> > +	++p;  /* skip space */
> 
> I guess I'd suggest
> 
> 	assert(*p == ' ');
> 	p++;
> 
> as defense against coders introducing additional cases that
> are not as careful.

Good suggestion, thanks.

> > @@ -2408,20 +2463,24 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
> >  	/* <dataref> or 'inline' */
> >  	if (*p == ':') {
> >  		char *x;
> > -		oe = find_mark(strtoumax(p + 1, &x, 10));
> > +		oe = find_mark(parse_mark_ref_space(p, &x));
> >  		hashcpy(sha1, oe->idx.sha1);
> >  		p = x;
> 
> Likewise (btw, why doesn't this share code with the filemodify case?):
> 
> 	if (*p == ':') {
> 		oe = find_mark(parse_mark_with_trailing_space(p, &p));
> 		hashcpy(sha1, oe->idx.sha1);
> 	} else if ...
> 
> and so on.

It does feel like a good opportunity for some refactoring.  Two
out of the three callers to parse an mark followed by a space
could be put together here.

[..]
> > @@ -2955,9 +3007,12 @@ static struct object_entry *parse_treeish_dataref(const char **p)
> >  	} else {	/* <sha1> */
> >  		if (get_sha1_hex(*p, sha1))
> >  			die("Invalid SHA1: %s", command_buf.buf);
> > -		e = find_object(sha1);
> >  		*p += 40;
> > +		if (**p != ' ')
> > +			die("Missing space after SHA1: %s", command_buf.buf);
> > +		e = find_object(sha1);
> 
> This seems dangerous.  What if a new caller arises that wants to
> parse a <dataref> representing a tree-ish at the end of the line?
> 
> So I think checking the character after the tree-ish should still
> be the caller's responsibility.

I was close to just moving parse_treeish_dataref() into its
single caller, parse_ls(), just so we wouldn't have to think
about this.

There are two cases it handles:  mark and sha1.  The mark case
uses the handy new parse_mark_ref_space(), which does the space
checking.  The sha1 branch had no check in this function.  So
I hoisted the space check up to make the branches symmetrical.

> >  	}
> > +	*p += 1;  /* skip space */
> 
> If other patches in flight use the same function, they would expect
> *p to point to the space when parse_treeish_dataref returns.  If we
> wanted to change that (as mentioned above I don't think we ought to)
> then the function's name should be changed to force such new callers
> not to compile.
> 
> > @@ -3008,8 +3063,6 @@ static void parse_ls(struct branch *b)
> >  		root = new_tree_entry();
> >  		hashcpy(root->versions[1].sha1, e->idx.sha1);
> >  		load_tree(root);
> > -		if (*p++ != ' ')
> > -			die("Missing space after tree-ish: %s", command_buf.buf);
> 
> (here's the caller).

I would prefer just to inline the whole thing.  Or new name
parse_ls_dataref() if you have a preference.

> Except where noted above, this looks good.

Thanks.

		-- Pete
