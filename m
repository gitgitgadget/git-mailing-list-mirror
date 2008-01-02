From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 20:31:14 +0100
Message-ID: <20080102193114.GA4608@efreet.light.src>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org
To: Gonzalo =?utf-8?Q?Garramu=C3=B1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:31:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA9Jd-0001Uu-CP
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 20:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYABTbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 14:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYABTbY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 14:31:24 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:56109 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYABTbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 14:31:23 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B88BC5737D;
	Wed,  2 Jan 2008 20:31:21 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id UNdITYS4I9Wv; Wed,  2 Jan 2008 20:31:18 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0CF29572CA;
	Wed,  2 Jan 2008 20:31:18 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JA9J4-0001WZ-8i; Wed, 02 Jan 2008 20:31:14 +0100
Content-Disposition: inline
In-Reply-To: <477B6199.6070601@advancedsl.com.ar>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69487>

On Wed, Jan 02, 2008 at 07:04:09 -0300, Gonzalo Garramu=C3=B1o wrote:
> Felipe Balbi wrote:
>>
>> it's easy on the full repository case, create different groups and
>> share git repositories by groups, after that chmod o-rwx -R
>> /path/to/repository.git.
>>
>
> Thanks.  I'll admit what you describe is somewhat discouraging, as wh=
at you=20
> are just describing is just managing user accounts or groups on the=20
> underlying OS.  That does not extend well to placing code on the net =
and=20
> has a bunch of administrative headaches.
>
> I was really looking for a permission based system that was part of g=
it=20
> itself (and thus more portable and easier to admin), and not the OS.=20
> Something akin to what perforce or even CVS can do.

You don't need to manage user accounts -- managing ssh public keys will=
 do!

The git ssh access will always run one particular command (with path as
argument) to push and another particular command (again with path as
argument) to pull.

Thus you can prepare two scripts -- git-read-only will only run
$SSH_ORIGINAL_COMMAND if it is 'git-upload-pack <somearg>' and git-read=
-write
will also run it if it is 'git-receive-pack <somearg>'. The <somearg> i=
s path
to the repository, so you can further limit on that. (Note: for recent =
git,
you need to recognize the 'git upload-pack' and 'git receive-pack' vari=
ants
too).

Now you can have each user create a ssh public key. You will put this k=
ey
into the .ssh/authorized_keys file on the server (therefore you only ne=
ed
a single account there), with option command=3D specifying appropriate =
script
depending on what permissions the user should have. Than that user will=
 be
able to push/pull (as set) via ssh using that public key and will not h=
ave
any other access to the server.

As a bonus, this way the users can't circumvent the pre-receive hooks
(perhaps you will allow each user to only push to a particular branch o=
r
something) by manually changing the repository.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
