From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC v2 2/2] git-p4: warn if git authorship won't be
 retained
Date: Mon, 9 May 2011 18:39:28 -0400
Message-ID: <20110509223928.GB1716@arf.padd.com>
References: <1304923203-26278-1-git-send-email-luke@diamand.org>
 <1304923203-26278-2-git-send-email-luke@diamand.org>
 <1304923203-26278-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 10 00:39:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZ74-00038x-3X
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767Ab1EIWjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:39:32 -0400
Received: from honk.padd.com ([74.3.171.149]:37773 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755680Ab1EIWjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:39:32 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 2486B20B7;
	Mon,  9 May 2011 15:39:31 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8ABF85AA98; Mon,  9 May 2011 18:39:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1304923203-26278-3-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173278>

luke@diamand.org wrote on Mon, 09 May 2011 07:40 +0100:
> If the git commits you are submitting contain changes made by
> other people, the authorship will not be retained. Change git-p4
> to warn of this and to note that --preserve-user can be used
> to solve the problem (if you have suitable permissions).
> The warning can be disabled.
> 
> Add a test case and update documentation.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>

This addresses Junio's concerns and makes more sense to me too.
It is odd for someone to submit commits not their own, but if
they want to, at least the warning can be hushed.

Two teensy fixes:

> +            if self.checkAuthorship and not self.p4UserIsMe(p4User):
> +                submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
> +                submitTemplate += "######## Use git-p4 option --preserve-user to modify authorship\n"
> +                submitTemplate += "######## Use git-p4 config git-p4.skipUserNameCheck hides this messsage.\n"
> +

s/messsage/message/


>              separatorLine = "######## everything below this line is just the diff #######\n"
>  
>              [handle, fileName] = tempfile.mkstemp()
> @@ -998,6 +1022,11 @@ class P4Submit(Command, P4UserMap):
>              commits.append(line.strip())
>          commits.reverse()
>  
> +        if not self.preserveUser and (gitConfig("git-p4.skipUserNameCheck") != "true"):
> +            self.checkAuthorship = True
> +        else:
> +            self.checkAuthorship = False
> +

Can we have a bit clearer logic?  I get confused with too many
negatives.

	#
	# Issue a warning in the submission template if the
	# author of the patch is different from the submitter.
	# But if preserveUser is used, the authorship will be
	# adjusted, hence no warning.  Also this message can be
	# hushed with a config option.
	#
	self.checkAuthorship = True
	if self.preserveUser:
	    self.checkAuthorship = False
	if gitConfig("git-p4.skipUserNameCheck") != "true":
	    self.checkAuthorship = False

> +make_change_by_user() {
> +    file=$1
> +    name=$2
> +    email=$3
> +	echo "username: a change by $name" >> $file &&
> +	git add $file &&
> +	git commit --author "$name <$email>" -m "a change by $name"
> +}

Tab/space oddities.

> +# If we're *not* using --preserve-user, git-p4 should warn if we're submitting
> +# changes that are not all ours.
> +# Test: user in p4 and user unknown to p4.
> +# Test: warning disabled and user is the same.
> +test_expect_success 'not preserving user with mixed authorship' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	cd "$git" &&
> +	git config git-p4.skipSubmitEditCheck true

Missing &&.  These are hard to remember, and I've been corrected
before too.

> +	p4_add_user derek Derek &&
> +
> +	make_change_by_user usernamefile3 Derek derek@localhost &&
> +	(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "git author derek@localhost does not match") &&
> +	git diff --exit-code HEAD..p4/master &&
> +
> +	make_change_by_user usernamefile3 Charlie charlie@localhost &&
> +	(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "git author charlie@localhost does not match") &&
> +	git diff --exit-code HEAD..p4/master &&
> +
> +	make_change_by_user usernamefile3 alice alice@localhost &&
> +	!(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "does not match") &&
> +	git diff --exit-code HEAD..p4/master &&
> +
> +	git config git-p4.skipUserNameCheck true &&
> +	make_change_by_user usernamefile3 Charlie charlie@localhost &&
> +	!(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "git author charlie@localhost does not match") &&
> +	git diff --exit-code HEAD..p4/master &&

Maybe -q on the greps.  Not a big deal.

> +	p4_check_commit_author usernamefile3 alice &&
> +	cd "$TRASH_DIRECTORY" &&
> +	rm -rf "$git" && mkdir "$git"
> +'

If you're okay on these fixes, go ahead and add my Acked-By for
the resend to Junio.

		-- Pete
