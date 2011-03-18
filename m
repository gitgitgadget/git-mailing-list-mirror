From: Todd Zullinger <tmz@pobox.com>
Subject: Git fails to detect subcommand when hook is symlinked to a builtin
Date: Fri, 18 Mar 2011 11:14:15 -0400
Message-ID: <20110318151415.GC26236@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="unl2YYqPcAwXdP9c"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 16:14:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0bNl-0003md-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab1CRPOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 11:14:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752486Ab1CRPOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 11:14:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAC312A6D
	for <git@vger.kernel.org>; Fri, 18 Mar 2011 11:14:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=sasl; bh=/p/Gh+
	8bxoRLqLIO1JnOELNW8Vk=; b=hEACHyx2ZgUlrWUgvRrpUVC6ymXQSQefVLaZi8
	1i4JM71SAOA0K/gdFk0LNeqUicdxPn700GQBVSKilZe1YII9L6bgk8M09uWQXmsp
	JkGjhKNm75ziD4mlvVwL/cTXrmrJHNperOuZdiR66WOhEfl9w2GqVQ1QsQostTMi
	LVpjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
	Xt06EZQg2RZGgIbbb3HACoy5/SGN00S2zvh+LSaJrlcLGfO4U5+LpkGtlpVts8QP
	Pwy/ZcUrU7cI9GfhBZ0GQI9ut9QMfKv+8YCV7MebwKiJK2lqk/xhf2e6vI9taA5Z
	rLgUwGLxLBwmBKLYeUUpCN8dQYIdA+aY1htfMNO/laA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A78322A6C
	for <git@vger.kernel.org>; Fri, 18 Mar 2011 11:14:18 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A2842A67 for
 <git@vger.kernel.org>; Fri, 18 Mar 2011 11:14:18 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: 65217B76-5172-11E0-BC20-C1F4E168B6F2-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169332>


--unl2YYqPcAwXdP9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm not sure if this is a bug or more of a "don't do that" sort of
thing.  At fedorahosted.org, the git repositories are mounted on a
filesystem with noexec.  As such, we have all hooks symlinked
elsewhere.  For the post-update hook we used to link directly to
git-update-server-info.

This worked until we upgraded the system to git-1.7.4.1 recently.  A
trace may help illustrate:

With hooks/post-update as a symlink to
/usr/bin/git-update-server-info:

trace: run_command: 'hooks/post-update' 'refs/heads/master'
trace: run_command: 'gc' '--auto' '--quiet'
remote: trace: exec: 'git-refs/heads/master'
remote: trace: run_command: 'git-refs/heads/master'
remote: git: 'refs/heads/master' is not a git command. See 'git --help'.

With hooks/post-update as a symlink to
/usr/share/git-core/templates/hooks/post-update.sample:

trace: run_command: 'hooks/post-update' 'refs/heads/master'
remote: setup: git_dir: .
remote: setup: worktree: (null)
remote: setup: cwd: /home/fedora/tmz/tmp/iwhd.git
remote: setup: prefix: (null)
remote: trace: built-in: git 'update-server-info'

Is there any reasonable way to handle this case?  Perhaps if the
symlink were dereferenced (if no subcommand were found) and then
re-checked for a subcommand?  I admit that I did not delve too deeply
into the code, but from the little I did I wasn't sure that any
changes here wouldn't lead to worse troubles.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Everyone needs to believe in something. I believe I'll have another
beer.


--unl2YYqPcAwXdP9c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJNg3bHJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjLRUIAJDfhwBZqn1fPq+jlSc4KZuJtE6C3rB5elfS
bYUdwB3z+M+LKIVv+0kDvVqR4hM3p7AUU7tdu6VdvvxuRAjkioB+gBk4iIbgKPgY
PU95kqzoCdPPvazPtsoarKAb9Ki72t7SlLq3KdLopIz9jQNt0vCq/p9eRIF/QFyn
1m1XCa09RWjHlwIKjMQFZh/TffbZC0Evqw+UbLd90b4KBZNIW46+R8/kMEsRkn74
OfdmIRLxBcOKb6/sG22/qevV/O4E2utNF9bTo2GzIkJ9zlG+nPWeNBepovPFAMF6
nPZV+yLkZgY5VqHtVfexNHZjcUoTtyjaTt/yTjj0veFFEpVEKu0=
=nVnx
-----END PGP SIGNATURE-----

--unl2YYqPcAwXdP9c--
