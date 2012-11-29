From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 06:46:37 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121129114637.GB9264@thyrsus.com>
References: <20121129055946.2D7B84065F@snark.thyrsus.com>
 <20121129075829.GE3424@lp-shahaf.local>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, git@vger.kernel.org
To: Daniel Shahaf <danielsh@elego.de>
X-From: dev-return-23040-gcvsd-dev=m.gmane.org@subversion.apache.org Thu Nov 29 12:47:26 2012
Return-path: <dev-return-23040-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-23040-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1Te2aU-0000EY-59
	for gcvsd-dev@plane.gmane.org; Thu, 29 Nov 2012 12:47:26 +0100
Received: (qmail 35242 invoked by uid 500); 29 Nov 2012 11:47:07 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 35184 invoked by uid 99); 29 Nov 2012 11:47:05 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Thu, 29 Nov 2012 11:47:05 +0000
X-ASF-Spam-Status: No, hits=-0.0 required=5.0
	tests=SPF_HELO_PASS,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of esr@thyrsus.com designates 71.162.243.5 as permitted sender)
Received: from [71.162.243.5] (HELO snark.thyrsus.com) (71.162.243.5)
    by apache.org (qpsmtpd/0.29) with ESMTP; Thu, 29 Nov 2012 11:46:59 +0000
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 85A254065F; Thu, 29 Nov 2012 06:46:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121129075829.GE3424@lp-shahaf.local>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210829>

Daniel Shahaf <danielsh@elego.de>:
> > Subversion's metadata doesn't have separate author and committer
> > properties, and doesn't store anything but a Unix user ID as
> > attribution.  I don't see any way around this.
> 
> You're not fully informed, then.
> 
> 1) svn:author revprops can contain any UTF-8 string.  They are not
> restricted to Unix user id's.  (For example, they can contain full
> names, if the administrator so chooses.)

Right.  At one point during the development of this feature I was
accidentally storing the full email field in this property.  So I
already knew that this is allowed at some level.  

And, I have no trouble believing that svn log will cheerfully echo
anything that I choose to stuff in that field.  

But...

(1) How much work would it be it to set up a Subversion installation 
so that when I svn commit, the tool does the right thing, e.g. puts
a DVCS-style fullname/email string in there?  

(2) Have the tools been tested for bugs arising from having whitespace
in that data?

Really, if it's actually easy to set up DVCS-style globally unique IDs you
Subversion guys ought to be shouting it from the housetops.  The absence
of this capability is a serious PITA in several situations, including 
for example migrating projects between forges.

RFC: If I wrote a patch that let Subversion users set their own
content string for the author field in ~/.subversion/config, would
you merge it?  Because I'd totally write that.

> 2) You can define custom revision properties.  In your case, the easiest
> way would be to set an reposurgeon:author property, alongside the
> svn:author property.

Yeah, sure, I've assumed all along this wouldn't break if I tried it.
If I actually thought you guys were capable of designing a data model
with a perfectly general-looking store of key/value pairs and then
arbitrarily restricting the key set so I couldn't do that, I'd almost
have to find each and every one of you and kick your asses into next
Tuesday on account of blatant stupidity. I have no such plans :-).

But...what good does this capability do?  OK, it would assist
round-tripping back to gitspace, but while that's kind of cool I don't
see any help for a normal Subversion workflow here.
 
> You might also seek community consensus to reserve an svn:foo name for
> the "original author" property --- perhaps svn:original-author --- so
> that reposurgeon and other git->svn tools can interoperate in the way
> they transfer the "original author" information.

OK.  But I like the idea of letting the users set their own author
content string better.  Instead of another layer of kluges, why
shouldn't Subversion join the DVCSes in the happy land of
Internet-scoped attributions?

> How does reposurgeon handle empty directories with (node) properties?

Currently by ignoring all of them except svn:ignore, which it turns 
into .gitignore content on the gitspace side.  And now vice-versa, too.

Not clear what else it *could* do.  I'd take suggestions.

> >   Subversion has a concept of "flows"; that is, named segments of
> >   history corresponding to files or directories that are created when
> >   the path is added, cloned when the path is copied, and deleted when
> >   the path is deleted. This information is not preserved in import
> >   streams or the internal representation that reposurgeon uses.  Thus,
> >   after editing, the flow boundaries of a Subversion history may be
> >   arbitrarily changed.
> > 
> > This is me being obsessive about documenting the details.  I think it
> > is doubtful that most Subversion users even know flows exist.
> 
> I think you're saying that adds might turn into copies, and vice-versa.
> That is something users would notice --- it is certainly exposed in the
> UI --- even though node-id's are not exposed to clients.

I'm saying nobody thinks of flows when they do branch copies.  It's
not just that users don't see node IDs, it's that no part of most users'
mental model of how Subversion works resembles them.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
