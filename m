From: Daniel Shahaf <danielsh@elego.de>
Subject: Re: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 09:58:29 +0200
Message-ID: <20121129075829.GE3424@lp-shahaf.local>
References: <20121129055946.2D7B84065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: dev-return-23038-gcvsd-dev=m.gmane.org@subversion.apache.org Thu Nov 29 09:00:51 2012
Return-path: <dev-return-23038-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-23038-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1Tdz3B-0003y7-5U
	for gcvsd-dev@plane.gmane.org; Thu, 29 Nov 2012 09:00:49 +0100
Received: (qmail 39555 invoked by uid 500); 29 Nov 2012 08:00:36 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 39503 invoked by uid 99); 29 Nov 2012 08:00:34 -0000
Received: from athena.apache.org (HELO athena.apache.org) (140.211.11.136)
    by apache.org (qpsmtpd/0.29) with ESMTP; Thu, 29 Nov 2012 08:00:34 +0000
X-ASF-Spam-Status: No, hits=-0.0 required=5.0
	tests=SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (athena.apache.org: local policy)
Received: from [78.47.87.163] (HELO mx0.elegosoft.com) (78.47.87.163)
    by apache.org (qpsmtpd/0.29) with ESMTP; Thu, 29 Nov 2012 08:00:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 19562DE065;
	Thu, 29 Nov 2012 08:59:50 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zJIrhou2ESuG; Thu, 29 Nov 2012 08:59:50 +0100 (CET)
Received: from lp-shahaf.local (unknown [109.65.228.49])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 7AC4DDE063;
	Thu, 29 Nov 2012 08:59:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121129055946.2D7B84065F@snark.thyrsus.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210819>

Eric S. Raymond wrote on Thu, Nov 29, 2012 at 00:59:45 -0500:
>   In summary, Subversion repository histories do not round-trip through
>   reposurgeon editing. File content changes are preserved but some
>   metadata is unavoidably lost.  Furthermore, writing out a DVCS history
>   in Subversion also loses significant portions of its metadata.
> 
>   Writing a Subversion repository or dump stream discards author
>   information, the committer's name, and the hostname part of the commit
>   address; only the commit timestamp and the local part of the
>   committer's email address are preserved, the latter becoming the
>   Subversion author field.  However, reading a Subversion repository and
>   writing it out again will preserve the author fields.
> 
> Subversion's metadata doesn't have separate author and committer
> properties, and doesn't store anything but a Unix user ID as
> attribution.  I don't see any way around this.

You're not fully informed, then.

1) svn:author revprops can contain any UTF-8 string.  They are not
restricted to Unix user id's.  (For example, they can contain full
names, if the administrator so chooses.)

2) You can define custom revision properties.  In your case, the easiest
way would be to set an reposurgeon:author property, alongside the
svn:author property.

You might also seek community consensus to reserve an svn:foo name for
the "original author" property --- perhaps svn:original-author --- so
that reposurgeon and other git->svn tools can interoperate in the way
they transfer the "original author" information.

I note that one can set revision properties at commit time:

    svn commit -m logmsg --with-revprop svn:original-author="Patch Submitter <foo@bar.example>"

>   Empty directories aren't represented in import streams. Consequently,
>   reading and writing Subversion repositories preserves file content,
>   but not empty directories.  It is also not guaranteed that after
>   editing a Subverson repository that the sequence of directory
>   creations and deletions relative to other operations will be
>   identical; the only guarantee is that enclosing directories will be
>   created before any files in them are.

How does reposurgeon handle empty directories with (node) properties?

% svnadmin create r
% svnmucc -mm -U file://$PWD/r mkdir foo propset k v foo

>   Subversion has a concept of "flows"; that is, named segments of
>   history corresponding to files or directories that are created when
>   the path is added, cloned when the path is copied, and deleted when
>   the path is deleted. This information is not preserved in import
>   streams or the internal representation that reposurgeon uses.  Thus,
>   after editing, the flow boundaries of a Subversion history may be
>   arbitrarily changed.
> 
> This is me being obsessive about documenting the details.  I think it
> is doubtful that most Subversion users even know flows exist.
> 

I think you're saying that adds might turn into copies, and vice-versa.
That is something users would notice --- it is certainly exposed in the
UI --- even though node-id's are not exposed to clients.

> 

Cheers

Daniel
