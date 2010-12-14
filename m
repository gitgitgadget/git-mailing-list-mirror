From: Edward Rudd <urkle@outoforder.cc>
Subject: Re: [git-svn] always prompted for passphrase with subversion 1.6
Date: Tue, 14 Dec 2010 09:33:44 -0500
Message-ID: <4D078048.3040602@outoforder.cc>
References: <4A95D58C.1070409@hp.com> <20090905064649.GD22272@dcvr.yhbt.net> <4AA84F46.6010706@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 15:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSVyJ-0000Zj-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 15:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab0LNOfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 09:35:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:54157 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab0LNOfL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 09:35:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSVy4-0000S7-P7
	for git@vger.kernel.org; Tue, 14 Dec 2010 15:35:04 +0100
Received: from adsl-75-46-74-191.dsl.ipltin.sbcglobal.net ([75.46.74.191])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 15:35:04 +0100
Received: from urkle by adsl-75-46-74-191.dsl.ipltin.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 15:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-75-46-74-191.dsl.ipltin.sbcglobal.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <4AA84F46.6010706@hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163648>

On 09/09/2009 08:58 PM, Tim Potter wrote:
> It's probably just a matter of adding another entry to the
> _auth_providers() function in git-svn.  My thought was that there might
> be a new auth provider in the Subversion 1.6 client library for GNOME
> Keyring support that could be used for this.
> 
> I'll have a search through and see what I can find.

I've been tracking subversion bug # 3612
(http://subversion.tigris.org/issues/show_bug.cfg?id=3612 )  which is on
this issue of perl binding not supporting platform specific providers.

A patch was added into subversion 1.6.15 that finally adds bindings for
perl to access this functionality via a call to
SVN::Core::auth_get_platform_specific_client_providers and adding it's
contents to the array returned by _auth_providers..

The "test" modification I did to git-svn is as follows.

sub _auth_providers () {
  (
    SVN::Core::auth_get_platform_specific_client_providers(undef,undef),
    [
      SVN::Client::get_simple_provider(),
      .... the rest of the static provider ...
    ]
  )
}

I'm honestly not sure if it should be at the beginning or end, and this
also needs some run-time checking to determine if the user has at least
SVN 1.6.15 installed
