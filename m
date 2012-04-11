From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 11 Apr 2012 14:53:51 -0500
Message-ID: <20120411195351.GG4248@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <1421035.yALBSXSHGd@flomedio>
 <20120410171707.GA3869@burratino>
 <2866164.rI5svgrW1x@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI3cQ-0002R9-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015Ab2DKTyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 15:54:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61739 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046Ab2DKTx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 15:53:57 -0400
Received: by iagz16 with SMTP id z16so1691969iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bd+hcloT57zXThJ/tM4ihz/mdl8r4gWm3xBoaKpNV6U=;
        b=aIjVorPi/K2VTEHxS8MMQLskRI6bGbNvF3dbkmT+JTe+lq08Vq6kmWV2cSvFmNvwtG
         GVn4sawHaZcN/HxX4bbP7AJfxSyeFkM9DI4CBzRPqk9ZA+8jU3aRz6zJFD1g3MOn6MW7
         a+tenpqOWcWxU98YVGSyeV9+y7Fdr538nLGfzGv5JQob5SXMbcsVluNqU2V+1r+33zrb
         zgZTBVxIbfzzw3QvsGwGU2xdwy65+ghCvCt/ZoKf9dum39Lg9a/ZlZtvOrxUIf9hBlSg
         ya2dlGHes2jHD9aP5d/W7WpwLwGumSm2FvWgmc7kYfEqlPmWF/YxATu89w7uuyJh73Z5
         h38Q==
Received: by 10.50.51.226 with SMTP id n2mr6923652igo.68.1334174037017;
        Wed, 11 Apr 2012 12:53:57 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id df1sm26277269igb.12.2012.04.11.12.53.55
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 12:53:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2866164.rI5svgrW1x@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195246>

Florian Achleitner wrote:

> If the remote-svn-alpha script is really all that needs to be done, you're 
> right. It just pipes through svn-fe. I thought svn-fe could only import an svn 
> repo initially, and there would be some difference between importing the whole 
> history and fetching new revisions later, (?).

Yes, Dmitry's script (not the first version, but a later one) supports
incremental imports without trouble if I remember correctly.

[...]
> Listing patches and planing all details in the submitted proposal would 
> require me to know what I do and how I will do it all before last Friday! As 
> I'm not yet an expert on this topic, I don't know how I could have known all 
> details a-priori.

Oh, I didn't mean you would need to do that alone. :)  Dmitry, David,
Ram, Sverre, and I should be able to answer any questions you have
about how git, vcs-svn, svnrdump, and the transport-helper currently
work in the importer.

I've marked the proposal editable to allow details to be filled in.

[...]
> I planned to implement a remote-helper using the existing interface 
> specification to communicate over pipes with git's transport-helper. 
> Instead of invoking svn-fe as a subprocess, I want to call vcs-svn/ functions 
> directly from the remote-helper and place new functions in this directory (?).

Ah, this is a good place to start.  In my diagram I lumped everything
under vcs-svn/ together as svn-fe for convenience, but in fact the
vcs-svn lib is made up of multiple components:

	caller
	 .
	 :
	 |
	public interface (svndump_init, svndump_read, etc)
	 |
	 |
	 |
	dump file parser (svndump_read body)
	 |
	 |
	 |
	fast-export interface (fast_export_*, repo_*) --------- svndiff0 parser
	 |
	 :
	 .
	git fast-import

Each component has a narrow interface.  For each action in the dump,
svndump_read() calls some appropriate function from the fast-export
interface to bring about the corresponding change on the git side.
Details of svndump syntax and the state needed to parse it are
isolated in svndump.c and details of fast-import syntax are in
fast-export.c and repo_tree.c.

(The structure used to be more complicated when the repo_* functions
had to keep track of the repository state instead of relying on
fast-import for that.)

Where would the branch mapping go?  What kind of state needs to be
maintained as it occurs?  What steps would I follow to imitate the
code and work out a branch mapping on paper?  How do I invoke the code
if I want to try it out (i.e., what functions form the public
interface needed to support branch mapping)?

I don't expect you to have answers to all these questions already; I
understand that getting used to what's already there and trying out
ideas will take time.  However, I do think we have a much better
chance of this going well if there are answers to these questions by
the time the coding period starts.

[...]
> Additionally the remote-helper will read a configuration file containing 
> additional information about branch-mapping, this should be closely related to 
> Andrew's SBL.

That sounds reasonable to me.  I am somewhat unconvinced (but
convinceable) about the need to use a configuration scheme that
handles all the edge cases right away.  Shouldn't it be enough to tell
the importer the following?

 - the path to the repository (from which it can deduce $SVNROOT
   and the path within there to the subproject of interest)

 - a single bit of information on top of that: "this repository uses
   the standard layout"

Once that works, the tools could easily be tweaked to respect a
configuration file that describes more complex situations, and as a
bonus the SBL tools for making sense of those situations would have
time to become more mature in the meantime.

Thanks for some useful clarifications.
Jonathan
