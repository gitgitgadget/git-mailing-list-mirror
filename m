From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 10 Nov 2012 13:44:37 -0500
Message-ID: <20121110184437.GC2739@mjolnir>
References: <cover.1352431674.git.wking@tremily.us>
 <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
 <7v390jqlep.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:45:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXG3U-00013g-QR
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 19:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab2KJSpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 13:45:07 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:45086 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2KJSpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 13:45:06 -0500
Received: from mjolnir.tremily.us ([unknown] [69.141.221.103])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDA00IJ5C2K6J00@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 10 Nov 2012 12:44:46 -0600 (CST)
Received: by mjolnir.tremily.us (Postfix, from userid 1000)
	id A4271271CAB; Sat, 10 Nov 2012 13:44:37 -0500 (EST)
Content-disposition: inline
In-reply-to: <7v390jqlep.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209291>

On Thu, Nov 08, 2012 at 11:34:54PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> 
> > By remaining agnostic on the variable usage, this patch makes
> > submodule setup more convenient for all parties.
> 
> I personally do not think "remaining agnostic on the usage" is a
> good thing, at least for any option to commands at the higher level
> on the stack, such as "git submodule".  I am afraid that giving an
> easier way to set up a variable with undefined semantics may make
> setup more confusing for all parties.  One party gives one specific
> meaning to the field, while another party uses it for something
> slightly different.
> 
> I would not object to "git config submodule.$name.branch $value", on
> the other hand.  "git config" can be used to set a piece of data
> that has specific meaning, but as a low-level tool, it is not
> _limited_ to variables that have defined meaning.

This is what I'm doing now:

  $ git submodule add -b <branch> <repo> <path>
  $ git config --file .gitmodules submodule.<path>.branch <branch>
  $ git submodule foreach 'git checkout $(git config --file $toplevel/.gitmodules submodule.$name.branch) && git pull'

With my second patch (Phil's config export), that becomes

  $ git submodule add -b <branch> <repo> <path>
  $ git config --file .gitmodules submodule.<path>.branch <branch>
  $ git submodule foreach 'git checkout $submodule_branch && git pull'

With my first patch, that becomes

  $ git submodule add -rb <branch> <repo> <path>
  $ git submodule foreach 'git checkout $submodule_branch && git pull'

This seems pretty useful to me, but I'm still using
submodule.<name>.branch explicitly as a user, and Git is not
interpreting the option directly.  Users are free to store whatever
they like in that option, and use it however they wish:

  $ git submodule foreach 'do-crazy-stuff.sh $submodule_branch'

If we need a semantic interpretation to justify -r/--record, everyone
that's chimed in so far has agreed on the same interpretation.  I
wouldn't be averse to

  $ git submodule add -rb <branch> <repo> <path>
  $ git submodule pull-branch

which makes the foreach pull logic internal.  However, there has been
a reasonable amount of resistance to this workflow in the past, so I
thought that a patch series that avoided a semantic interpretation
would be more acceptable.

If neither an agnostic -r/--record or a semantic pull-branch command
are acceptable, I suppose we'll have to drop my first and third
patches and only keep the second.

Trevor

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
