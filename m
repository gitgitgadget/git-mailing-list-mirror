From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: do not include the branch name as the first line of commit msg
Date: Mon, 03 Dec 2007 17:20:01 -0800
Message-ID: <7vsl2jcl32.fsf@gitster.siamese.dyndns.org>
References: <4751A036.1080209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stelian@popies.net, gitster@pobox.com, git@vger.kernel.org
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMSe-0006cG-EG
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXLDBUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXLDBUK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:20:10 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56098 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbXLDBUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:20:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 01062320;
	Mon,  3 Dec 2007 20:20:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 435B59CAB6;
	Mon,  3 Dec 2007 20:20:25 -0500 (EST)
In-Reply-To: <4751A036.1080209@gmail.com> (Mark Drago's message of "Sat, 01
	Dec 2007 12:56:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66985>

Mark Drago <markdrago@gmail.com> writes:

> Signed-off-by: Mark Drago <markdrago@gmail.com>
> ---
>  contrib/hg-to-git/hg-to-git.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
> index 7a1c3e4..6bff49b 100755
> --- a/contrib/hg-to-git/hg-to-git.py
> +++ b/contrib/hg-to-git/hg-to-git.py
> @@ -158,7 +158,7 @@ for cset in range(int(tip) + 1):
>          mparent = None
>  
>      (fdcomment, filecomment) = tempfile.mkstemp()
> -    csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag:' % cset).read().strip()
> +    csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag: | grep -v ^branch:' % cset).read().strip()
>      os.write(fdcomment, csetcomment)
>      os.close(fdcomment)

Isn't this one of the ugliest lines in the whole git.git project, I have
to wonder?

I also wonder missing colon after "date" is a bug from the original
version, and assuming that it is, how about doing something less error
prone like this?

        def included(line):
            keywords = ('changeset', 'parent', 'user', 'date', 'files',
                        'description', 'tag', 'branch')
            for kw in keywords:
                if line.startswith(kw + ':'):
                    return 0
            return 1

        hglog = os.popen('hg log -r %d -v' % cset).read();
        csetcomment = '\n'.join(filter(included, hglog.split('\n'))).strip()

If you are excluding _all_ of the <word>: header lines, the "included"
function may have to become cleverer but much simpler by doing something
like:

	import re
	header_re = re.compile(r'^\w+:')
	def included(line):
        	return not header_re.match(line)
