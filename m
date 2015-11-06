From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git blame performance
Date: Fri, 06 Nov 2015 15:52:56 +0100
Message-ID: <563CBEC8.7070209@alum.mit.edu>
References: <563CAD30.6040608@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Jan Smets <jan.smets@alcatel-lucent.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 15:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuiOG-0002bZ-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 15:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366AbbKFOxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 09:53:13 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51224 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752346AbbKFOxL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 09:53:11 -0500
X-AuditID: 12074411-f797e6d000007df3-de-563cbecada20
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D0.30.32243.ACEBC365; Fri,  6 Nov 2015 09:52:58 -0500 (EST)
Received: from [192.168.69.130] (p4FC96C46.dip0.t-ipconnect.de [79.201.108.70])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA6Equ0B024497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 6 Nov 2015 09:52:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <563CAD30.6040608@alcatel-lucent.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1D21zybM4P4MSYuuK91MFldPtTA6
	MHm0PtvL6vF5k1wAUxS3TVJiSVlwZnqevl0Cd8aEj0sZC34JVKy49om9gfEwbxcjB4eEgInE
	ivVhXYycQKaYxIV769m6GLk4hAQuM0rM/fOOEcI5xyRxYfp6JpAqXgFtiSW3fjKC2CwCqhLn
	Ls1gA7HZBHQlFvU0g9WICgRJrFj+ghGiXlDi5MwnLCC2iICjxI+db1hAFgsLKEmcmhgEYgoJ
	GEosPlMBUsEpYCTRsnEr2BRmAT2JHdd/sULY8hLNW2czT2Dkn4Vk6CwkZbOQlC1gZF7FKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERKMgjsYZ5yUO8QowMGoxMN7Y4l1mBBr
	YllxZe4hRkkOJiVR3pTZNmFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjjVgDleFMSK6tSi/Jh
	UtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvD57gRoFi1LTUyvSMnNKENJMHJwgw7mk
	RIpT81JSixJLSzLiQdEYXwyMR5AUD9DeoyDtvMUFiblAUYjWU4y6HGtm31/LJMSSl5+XKiXO
	+wikSACkKKM0D24FLPW8YhQH+liYdy5IFQ8wbcFNegW0hAloiUMU2JKSRISUVANjfdm37ed/
	tfTs1braG2wavVLkQe5TrvKIymkZ+i4vFpr4fFb3tvoZFfsppfLEp+izN5/uKJ5g6Tlv+Sdv
	EdmZmw1r1BftZHy7PHWb5oW0gjSZmI78Farav3ZErMipj14v193lFeS8iEs1937r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280988>

On 11/06/2015 02:37 PM, Jan Smets wrote:
> I have recently migrated a fairly large project from CVS to Git.
> One of the issues we're having is the blame/annotate performance.
> [...]
> cvs annotate of the same file (over the network) is ready in 0.8 seconds.
> blame/annotate is a frequently used operation, ranging between 5 to 20
> usages a day per developer.

cvs annotate and git blame both have to follow history back until they
find the commit that introduced the oldest line that is still in the
current version of the file. So for a really old file, a lot of history
has to be walked through.

The reason that cvs annotate is so much faster than git blame is that
CVS stores revisions filewise, with all of the modifications to file
$FILE being stored in a single $FILE,v file. So in the worst case, CVS
only has to read this one file.

Git, on the other hand, stores revisions treewise. It has no way of
knowing, ab initio, which revisions touched a given file. (In fact, this
concept is not even well-defined because the answer depends on things
like whether copy (-C) and move (-M) detection are turned on and what
parameters they were given.) This means that git blame has to traverse
most of history to find the commits that touched $FILE.

Slow git blame is thus a relatively unavoidable consequence of Git's
data model. That's not to say that it can't be sped up somewhat, but it
will never reach CVS speeds.

But it does have some features that can reduce the work:

-L <start>,<end>, -L :<funcname> -- Annotate only the given line range.
This option can speed things up (1) if the range of lines does not
include the oldest lines, (2) by limiting which parents of merge commits
have to be followed.

--incremental -- if you are using this command to build tooling, this
option allows partial results to be returned early, to reduce the wait
until the user sees something.

If you are not interested in changes older than a certain date or
revision, you can limit the amount of history that git blame traverses.
See SPECIFYING RANGES in the manpage.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
