From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC] fast-import: notemodify (N) command
Date: Mon, 31 Jan 2011 12:33:50 -0600
Message-ID: <20110131183350.GB31826@burratino>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
 <1255083738-23263-8-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: vcs-fast-import-devs@lists.launchpad.net
X-From: git-owner@vger.kernel.org Mon Jan 31 19:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjyZq-0003kA-Gr
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 19:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1AaSeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 13:34:09 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63859 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab1AaSeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 13:34:08 -0500
Received: by fxm20 with SMTP id 20so5907054fxm.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 10:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0QhWFwWCSqZV6k0AQlyqvgufNBxT+/LkrkqxRfnmKF0=;
        b=VhAh2JuohIk8A416yy0sbkj+zoiX5eqk6nDFV8HVmfn5Hi2qWHhqiNd29C5+LG18nG
         S0PheMvVFLeb89GA+nksIiTTQUozHy/a6UMXIZsbyXOfqo2nMd5ddSdszv1GVW8uRZPR
         70uK3+92BfxjXNN+TjQeM/O11sK7V2deq15v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NPBhCiuoCk/ZIyIZYHJOi1P9liqwZbhkhVPPXXqgW15Gk1iraWlmzxor6MOXTUJjNY
         q60ZixUPVjLVPRWI8IzBaHV/uPwJIr/KDlmYuuoA/2OjZF2E/3byAr8GpPAf1Vwcltu8
         llUXm/kG9X0gniqfzWJEzC1aWHwiB4uaeRehM=
Received: by 10.223.118.136 with SMTP id v8mr6340127faq.90.1296498845897;
        Mon, 31 Jan 2011 10:34:05 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id c11sm7501050fav.2.2011.01.31.10.34.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 Jan 2011 10:34:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1255083738-23263-8-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165738>

Dear fast importers,

Another week, another fast-import protocol extension.

Most DVCSes do not allow one to non-disruptively change the log
message for a commit.  But sometimes people want to attach information to a
commit after the fact:

 - whether it was tested and worked correctly
 - who liked or disliked the commit (Acked-by, Reviewed-by)
 - corresponding revision number after export to another version
   control system
 - bug number
 - corresponding compiled binary

The N command allows such notes to be attached to commits, like so:

 1. first the commit is imported as usual (let's say it's ":1").
 2. commit annotations are added separately, like so:

	commit refs/notes/commits
	committer A. U. Thor <author@example.com> Mon, 31 Jan 2011 12:15:59 -0600
	data <<END
	Notes after review.
	END

	N inline :1
	data <<END
	Acked-by: me
	END

Details:

 - there can be multiple categories of notes: "refs/notes/commits"
   contains ordinary addenda to the commit message, but one might also
   see refs/notes/bugzilla, refs/notes/svn-commit, and so on.

 - each commit gets at most one blob of notes in each category.  Later
   notemodify (N) commands overwrite the effect from earlier ones.

 - the syntax of a notemodify command is as follows:

	'N' sp <dataref> sp <committish> lf

   The <dataref> represents a blob with the annotations to be used
   ("inline" is allowed, too, just like with filemodify).  The
   <committish> can be any expression allowed in a 'from' command
   (branch name, mark reference :<idnum>, other commit name) and
   represents the commit that is to be annotated.

 - this has been supported in git since v1.6.6.  There is no
   "feature" for it --- I don't think the feature declaration
   facility existed yet.

Do other DVCSes support something like this?  Should it get a
feature name?

Jonathan
