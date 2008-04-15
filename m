From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-fast-import: note 1M limit of mark number
Date: Tue, 15 Apr 2008 17:50:38 +0200
Message-ID: <4804CECE.2040205@alum.mit.edu>
References: <20080415125222.C55C121CE8F@mail.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Apr 15 18:21:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlnRT-0000B1-8Y
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 17:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYDOPup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYDOPup
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 11:50:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51810 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYDOPup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 11:50:45 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] ([212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m3FFohTf020496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Apr 2008 17:50:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20080415125222.C55C121CE8F@mail.utsl.gen.nz>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79606>

Sam Vilain wrote:
> The insert_mark() function in fast-import.c has this limit; note the
> limitation in the documentation.
> 
> Signed-off-by: Sam Vilain <sam@vilain.net>
> ---
>  Documentation/git-fast-import.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index c29a4f8..b5cc3c2 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -410,6 +410,9 @@ or `refs/heads/42`), or an abbreviated SHA-1 which happened to
>  consist only of base-10 digits.
>  +
>  Marks must be declared (via `mark`) before they can be used.
> ++
> +Note that due to current internal limitations, you may not make marks
> +with a higher number than 1048575 (2^20-1).
>  
>  * A complete 40 byte or abbreviated commit SHA-1 in hex.
>  

Oh.  Um.  That is an awkwardly small number nowadays.

cvs2svn has been used for repositories with O(2^20) distinct file
revisions (KDE, Mozilla, NetBSD, ...).  So this limit will likely be too
small for some users.

Moreover, cvs2git needs to generate marks for both file contents and for
commits.  It generates the latter by adding 1000000000 to the small
integer IDs that it uses internally.  If git-fast-import only allows
20-bit integers, this makes me wonder why this hasn't broken
dramatically in the past.  Pure numerological good fortune, combined
with weak range checking in git-fast-import?

In any case, this restriction will require changes in cvs2git.

While I'm at it, let me also renew my suggestion that git-fast-import
use separate namespaces ("markspaces", so to speak) for file content
marks and for commit marks.  There is no reason for these distinct types
of marks to be located in a shared space of integers.

Michael
