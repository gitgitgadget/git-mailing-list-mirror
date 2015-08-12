From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 15:41:28 -0700
Message-ID: <xmqqmvxwjfjb.fsf@gitster.dls.corp.google.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
	<xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
	<CALKQrgf2hdvNExVbvnP5sVUM4sEh7thj9HLw93LbYWSStNjeYg@mail.gmail.com>
	<CA+P7+xrQnrQdE3OOhdc2-2__V3Huzc+HfGEXKBZULy2JkQR37Q@mail.gmail.com>
	<CA+P7+xp0zhqM4CHmFpKuPyNMTx3DBxiLSOsiwz=byrfTEDj3sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:41:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPeiG-0004qB-Db
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbHLWlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:41:31 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34738 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbHLWla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:41:30 -0400
Received: by pdbfa8 with SMTP id fa8so11838691pdb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LpXBI2EoVpV80Zb3vQGcDNKdlka1J24qPD3AMWxEYbM=;
        b=k4nPZaqOJBId6ujRLScyFaB1I8NmC6RLSQW0sXztAQOZSgzR5E+Ddl7ar2gauxmavF
         r7CHhB2verhcn1vkMEgmrpp64+s1GVV7egvA7EmcWs/zl6j81h8hf7VbOwcxLV3Bz2kZ
         R6CqPogBcKHuV3BzSTusbj5b+wP/M9KTuG2HjjLGia0F9Ntl5l2EO+6qs9jqISOD0RBL
         i0tVhaJReIQcsXh/GJNh5VmNS93fpRk7HfWqitAHVbwM5yEh0vq1Qu03XG7zn+FW+HkU
         FOrgnselD3VBYMPmyQgNhkXhXINskl5GP6EcpBsGLrsqqerj5NznzEJyiLCairKpQwXa
         3ePQ==
X-Received: by 10.70.132.228 with SMTP id ox4mr72656073pdb.0.1439419290032;
        Wed, 12 Aug 2015 15:41:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id p1sm181778pdb.3.2015.08.12.15.41.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 15:41:29 -0700 (PDT)
In-Reply-To: <CA+P7+xp0zhqM4CHmFpKuPyNMTx3DBxiLSOsiwz=byrfTEDj3sA@mail.gmail.com>
	(Jacob Keller's message of "Wed, 12 Aug 2015 15:03:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275823>

Jacob Keller <jacob.keller@gmail.com> writes:

> I spoke to soon. We have an "init_notes_check" function which shows
> that it does refuse to merge outside of refs/notes/* It prevents all
> notes operations outside of refs/notes

OK.  Then it is OK to limit notes.<ref>.mergestrategy so that <ref>
refers to what comes after refs/notes/, because we will not allow
merging to happen outside the hierarchy.

If you are planning to break that promise, however, <ref> must be
always spelled fully (i.e. with refs/notes/ prefix for those inside
the hierarchy) to avoid ambiguity.  Otherwise it will be hard to
interpret a configuration that does something like this (note that
these could come from multiple places, e.g. $HOME/.gitconfig and
$GIT_DIR/config):

    [notes "commits"]
        mergestrategy = concatenate
    [notes "notes/commits"]
        mergestrategy = cat_sort_uniq
    [notes "refs/notes/commits"]
        mergestrategy = overwrite

The three entries in the above example obviously are all meant to
refer to the same refs/notes/commits notes tree, and the usual "last
one wins" rule should apply.  But with the recent git_config_get_*()
interface, you cannot tell which one among them was given the last,
overriding the previous entries.
