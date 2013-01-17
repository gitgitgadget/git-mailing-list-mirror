From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 21:00:48 +0000
Message-ID: <20130117210048.GI4574@serenity.lan>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 <7vtxqftulq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 22:01:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvwaQ-0005Zs-A2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 22:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab3AQVBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 16:01:01 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:33584 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073Ab3AQVA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 16:00:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 25D0222F97;
	Thu, 17 Jan 2013 21:00:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pmoUcPfyDyFB; Thu, 17 Jan 2013 21:00:58 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id CDD0B22C86;
	Thu, 17 Jan 2013 21:00:57 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 917F9161E52D;
	Thu, 17 Jan 2013 21:00:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SPa4wdSlF1eh; Thu, 17 Jan 2013 21:00:57 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5AAA6161E480;
	Thu, 17 Jan 2013 21:00:50 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vtxqftulq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213878>

On Thu, Jan 17, 2013 at 12:36:33PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
>> Under Python 3 'hasher.update(...)' must take a byte string and not a
>> unicode string.  Explicitly encode the argument to this method as UTF-8
>> so that this code works under Python 3.
>>
>> This moves the required Python version forward to 2.0.
>>
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
> 
> Hmph.  So what happens when the path is _not_ encoded in UTF-8?

Do you mean encodable?  As you say below it will currently throw an
exception.

> Is the repo.hash (and local.hash that gets a copy of it) something
> that needs to stay the same across multiple invocations of this
> remote helper, and between the currently shipped Git and the version
> of Git after applying this patch?

It's used to specify the path of the repository for importing or
exporting, so it should stay consistent across invocations.  However,
this is only an example remote helper so I don't think we should worry
if it changes from one Git release to the next.

>                                    If that is not the case, and if
> this is used only to get a randomly-looking 40-byte hexadecimal
> string, then a lossy attempt to .encode('utf-8') and falling back to
> replace or ignore bytes in the original that couldn't be interpreted
> as part of a UTF-8 string would be OK, but doesn't .encode('utf-8')
> throw an exception if not told to 'ignore' or something?

You're right - I think we need to add ", errors='replace'" to the call
to encode.

> >  git-remote-testpy.py | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> > index d94a66a..f8dc196 100644
> > --- a/git-remote-testpy.py
> > +++ b/git-remote-testpy.py
> > @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
> >  from git_remote_helpers.git.importer import GitImporter
> >  from git_remote_helpers.git.non_local import NonLocalGit
> >  
> > -if sys.hexversion < 0x01050200:
> > -    # os.makedirs() is the limiter
> > -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
> > +if sys.hexversion < 0x02000000:
> > +    # string.encode() is the limiter
> > +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
> >      sys.exit(1)
> >  
> >  def get_repo(alias, url):
> > @@ -45,7 +45,7 @@ def get_repo(alias, url):
> >      repo.get_head()
> >  
> >      hasher = _digest()
> > -    hasher.update(repo.path)
> > +    hasher.update(repo.path.encode('utf-8'))
> >      repo.hash = hasher.hexdigest()
> >  
> >      repo.get_base_path = lambda base: os.path.join(
