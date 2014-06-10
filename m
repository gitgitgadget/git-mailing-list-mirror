From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Fix git-p4 submit in non --prepare-p4-only mode
Date: Tue, 10 Jun 2014 18:39:58 -0400
Message-ID: <20140610223958.GA10049@padd.com>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
 <20140524135215.GA9386@padd.com>
 <20140524174034.GA7560@nekage>
 <20140610121446.GA25634@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Maxime Coste <frrrwww@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:41:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUi9-0005Rq-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbaFJWkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:40:03 -0400
Received: from honk.padd.com ([71.19.245.7]:42652 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbaFJWkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:40:02 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id 282A23399;
	Tue, 10 Jun 2014 15:40:01 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6DC392078C; Tue, 10 Jun 2014 18:39:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140610121446.GA25634@nekage>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251318>

frrrwww@gmail.com wrote on Tue, 10 Jun 2014 13:14 +0100:
> b4073bb387ef303c9ac3c044f46d6a8ae6e190f0 broke git p4 submit, here
> is a proper fix, including proper handling for windows end of lines.

I guess we don't have test coverage for these cases?  Is this
something that should get put into a maintenance release, quickly?

The fix looks good.  It's surprising that none of the tests
managed to add a file and trigger the failure.

I'll ack this again, as it looks okay, but hope you ran all the
unit tests successfully on your machine.

		-- Pete

> Signed-off-by: Maxime Coste <frrrwww@gmail.com>
> ---
>  git-p4.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 7bb0f73..ff132b2 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1238,7 +1238,7 @@ class P4Submit(Command, P4UserMap):
>              if response == 'n':
>                  return False
>  
> -    def get_diff_description(self, editedFiles):
> +    def get_diff_description(self, editedFiles, filesToAdd):
>          # diff
>          if os.environ.has_key("P4DIFF"):
>              del(os.environ["P4DIFF"])
> @@ -1258,7 +1258,7 @@ class P4Submit(Command, P4UserMap):
>                  newdiff += "+" + line
>              f.close()
>  
> -        return diff + newdiff
> +        return (diff + newdiff).replace('\r\n', '\n')
>  
>      def applyCommit(self, id):
>          """Apply one commit, return True if it succeeded."""
> @@ -1422,10 +1422,10 @@ class P4Submit(Command, P4UserMap):
>          separatorLine = "######## everything below this line is just the diff #######\n"
>          if not self.prepare_p4_only:
>              submitTemplate += separatorLine
> -            submitTemplate += self.get_diff_description(editedFiles)
> +            submitTemplate += self.get_diff_description(editedFiles, filesToAdd)
>  
>          (handle, fileName) = tempfile.mkstemp()
> -        tmpFile = os.fdopen(handle, "w+")
> +        tmpFile = os.fdopen(handle, "w+b")
>          if self.isWindows:
>              submitTemplate = submitTemplate.replace("\n", "\r\n")
>          tmpFile.write(submitTemplate)
> @@ -1475,9 +1475,9 @@ class P4Submit(Command, P4UserMap):
>              tmpFile = open(fileName, "rb")
>              message = tmpFile.read()
>              tmpFile.close()
> -            submitTemplate = message[:message.index(separatorLine)]
>              if self.isWindows:
> -                submitTemplate = submitTemplate.replace("\r\n", "\n")
> +                message = message.replace("\r\n", "\n")
> +            submitTemplate = message[:message.index(separatorLine)]
>              p4_write_pipe(['submit', '-i'], submitTemplate)
>  
>              if self.preserveUser:
> -- 
> 2.0.0
> 
> 
