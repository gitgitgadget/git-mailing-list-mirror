From: Mike Hommey <mh@glandium.org>
Subject: Should notes handle replace commits?
Date: Fri, 8 Jan 2016 10:28:30 +0900
Message-ID: <20160108012830.GA2110@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:42:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHN0m-0004Nl-Tk
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 03:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbcAHCmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 21:42:42 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41260 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbcAHCmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 21:42:40 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <glandium@glandium.org>)
	id 1aHLqw-0000gJ-Iy
	for git@vger.kernel.org; Fri, 08 Jan 2016 10:28:30 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283525>

Hi,

Take the following dummy repo:

  $ git init
  $ git commit --allow-empty -m 'first'
  $ git notes add -m 'first note'
  $ git commit --allow-empty -m 'second'
  $ git notes add -m 'second note'
  $ git commit --allow-empty -m 'third'
  $ git notes add -m 'third note'

  $ git log --format='%s - %N'
  third - third note

  second - second note

  first - first note

Now, let's say you have some other history that you want to graft:

  $ git checkout --orphan old
  $ git commit --allow-empty -m 'real first'
  $ git notes add -m 'real first note'
  $ git commit --allow-empty -m 'real second'
  $ git notes add -m 'real second note'
  $ git commit --allow-empty -m 'real third'
  $ git notes add -m 'real third note'
  $ git log --format='%s - %N'
  real third - real third note

  real second - real second note

  real first - real first note

Assuming that the "first" commit on master is the same as the "real
third" on old, you can graft with:

  $ git rev-parse master~ old | xargs > .git/info/grafts

And then:
  $ git log master --format='%s - %N'
  third - third note

  second - second note

  real third - real third note

  real second - real second note

  real first - real first note

Now, if you try to do the same with replace:

  $ rm .git/info/grafts
  $ git replace master~2 old
  $ git log master --format='%s - %N'
  third - third note

  second - second note

  real third - first note

  real second - real second note

  real first - real first note

Note how "real third" now has "first note", instead of "real third
note".

So the question is, is this the behavior this should have?

Cheers,

Mike
