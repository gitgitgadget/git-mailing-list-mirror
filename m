From: Matt McCutchen <matt@mattmccutchen.net>
Subject: gitweb config with some public, some basic-authenticated repos
Date: Sat, 03 Jan 2009 13:29:16 -0500
Message-ID: <1231007356.3416.21.camel@localhost>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
	 <m3ljujg2eh.fsf@localhost.localdomain> <1230082831.2971.45.camel@localhost>
	 <200901022033.18041.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 19:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJBGo-0005gR-Ff
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 19:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbZACS3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 13:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZACS3V
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 13:29:21 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:54326 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751573AbZACS3U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jan 2009 13:29:20 -0500
Received: from [192.168.1.22] (pool-71-163-212-127.washdc.east.verizon.net [71.163.212.127])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id BB83013EBA;
	Sat,  3 Jan 2009 10:29:17 -0800 (PST)
In-Reply-To: <200901022033.18041.jnareb@gmail.com>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104477>

This thread's topic has moved from a proposed patch to how I should
configure my gitweb, so I'm updating the subject.  As a review: I have
several public repos and several basic-authentication realms, each of
which requires a single user and contains a single repo (some realms
might contain multiple repos in the future).  Each request has its
authorization checked by the Web server before it reaches gitweb, so my
main concern here is to avoid publicly disclosing the private repos'
paths, authors, and descriptions in the main project list.

On Fri, 2009-01-02 at 20:33 +0100, Jakub Narebski wrote: 
> On Wed, 2008-12-24, Matt McCutchen wrote:
> > On Sat, 2008-12-13 at 14:02 -0800, Jakub Narebski wrote:
> > >
> > > Cannot you do this with new $export_auth_hook gitweb configuration
> > > variable, added by Alexander Gavrilov in 
> > >    dd7f5f1 (gitweb: Add a per-repository authorization hook.)
> > > It is used in check_export_ok subroutine, and is is checked also when
> > > getting list of project from file
> > > 
> > > From gitweb/INSTALL
> [...]
> > >     For example, if you use mod_perl to run the script, and have dumb
> > >     http protocol authentication configured for your repositories, you
> > >     can use the following hook to allow access only if the user is
> > >     authorized to read the files:
> [...]
>  
> > $export_auth_hook would work, and it would have the nice (but not
> > essential) feature of including private projects in the list shown to
> > suitably authenticated users.  The only problem is that my Web host
> > doesn't support mod_perl.  Is there a practical way to accomplish the
> > same thing as the above example in a CGI script?  I would like to avoid
> > reimplementing Apache authentication-checking functionality if at all
> > possible.
> 
> I know it is written that the example code is for mod_perl, but I
> don't think it is mod_perl specific; have you checked if it works
> for you? I assume that you use Apache, and have Apache Perl bindings
> installed...

I'm quite sure that the code is mod_perl specific.  CGI scripts do get
some information from Apache via the environment, but interaction as
rich as executing Apache subrequests is only possible when the code is
running inside Apache via mod_perl.  In fact, the Apache2::SubRequest
and Apache2::RequestUtil modules are part of mod_perl.  To make sure I'm
not missing something, I tested the code on an Apache with mod_perl
enabled but gitweb executing as a CGI, and gitweb failed with the
following message:

        Can't locate object method "request" via package
        "Apache2::RequestUtil" at gitweb_config.perl line 60.

So this approach won't work for me.

But even ignoring this problem, I'm now thinking that trying to show
repos from *multiple authentication realms* in the main list according
to the user's credentials was a foolish idea.  I don't want to ask
anonymous visitors to my main list for multiple logins they probably
don't have, yet I think it would be poor practice from a predictability
standpoint for the list to behave differently if the user volunteers
login information that hasn't been requested.

Instead, I will use a separate project list file for public repositories
and for each realm, and no export_auth_hook.  This is simple and
requires no change to gitweb; my rewrite rule just has to tell my
gitweb_config via an environment variable which list to use.  Comments
on this solution?

(Note: I'm no longer advocating the hidden-repos feature at this time,
but I think I will still advocate the forks-and-strict-export bug fix
now that I have it written.)

-- 
Matt
