From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Tue, 22 Jan 2013 22:44:31 -0800
Message-ID: <7vy5fkiek0.fsf@alter.siamese.dyndns.org>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
 <CAJDDKr6exXh14m08HTihxREjSFgyPT0bN1cF8eUryXJHOgFL1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txu4t-0000Zs-SE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab3AWGof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:44:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045Ab3AWGoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:44:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9EEAB953;
	Wed, 23 Jan 2013 01:44:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5alIXYNrhXjjgfApqzrZDMd2XK4=; b=H/aDWW
	Q1t5as9YoeVEz9xPLeYYv8mW9Y5JldKBCAFuBxfySXH9QStLD9D/Mlqo63254TeP
	8te62DXdeolxXATKS+EdCFSmfgbdgjQLrnAEwmNB+ANkxLCmdFqkmAp+3FQQ+kSi
	7yDQVaI9Prls9crYwQ0lL28iDBjGemQ2euKBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u8a8eogQ0ZycD+2epLpdS/GuSanDNhqq
	ASs30/P89fWxv4yfeuFevcTYyjJUJ2u9IrS3lxKA5l7CKYli3k9nTn2Mh7r8G8GS
	c8W9kscU3Thc+bQ14MbGgHOMfFnUN0HGYAQEfNyseRuo8dATnTyjqN7toNfUG2PA
	ONkbhNug3mk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3E9B952;
	Wed, 23 Jan 2013 01:44:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DFBEB950; Wed, 23 Jan 2013
 01:44:33 -0500 (EST)
In-Reply-To: <CAJDDKr6exXh14m08HTihxREjSFgyPT0bN1cF8eUryXJHOgFL1A@mail.gmail.com> (David
 Aguilar's message of "Tue, 22 Jan 2013 16:43:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 586F301E-6528-11E2-868A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214291>

David Aguilar <davvid@gmail.com> writes:

>> +static int walk(struct strbuf *path, int argc, const char **argv)
>> +{
>> +       DIR *dir;
>> +       struct dirent *ent;
>> +       size_t len;
>> +
>> +       dir = opendir(path->buf);
>> +       if (!dir)
>> +               return errno;
>> +       strbuf_addstr(path, "/");
>> +       len = path->len;
>> +       while ((ent = readdir(dir))) {
>> +               if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
>> +                       continue;
>> +               if (!strcmp(ent->d_name, ".git")) {
>> +                       strbuf_setlen(path, len - 1);
>> +                       chdir(path->buf);
>> +                       handle_repo(path->buf, argv);
>> +                       chdir(root);
>> +                       strbuf_addstr(path, "/");
>> +                       continue;
>> +               }
>
> Does this section above properly handle .git files (where .git is a
> file, not a directory)?

This scans a directory $D to ask "is there '.git' in you?" and if
the answer is "yes", then hands $D (not "$D/.git") to handle_repo().
That logic will not miss a gitfile that points at the real $GIT_DIR
elsewhere.

There is a recursive call to walk() later in the same loop when the
found entry ent turns out to be a directory, and "$D/" + ent->d_name
is given to this function.

But I do not think the loop structure of this function is right.  If
$D has ".git" in it, should it even try to feed other subdirectories
of $D (say "$D/a") to itself in recursion to see if $D/a/.git exists?

I think it should be more like

	walk(struct strbuf *path)
        {
		size_t dirlen = path->len;
		int has_git;

		strbuf_addstr(path, "/.git");
		has_git = !lstat(path->buf);
		strbuf_setlen(path, dirlen);

                if (has_git) {
                        handle_repo(path->buf);
			return;
		}
                dir = opendir(path->buf);
		while ((ent = readdir(dir))) {
			... skip . and .. ...
			strbuf_addstr(path, ent->d_name);
			walk(path);
			strbuf_setlen(path, dirlen);
                }
	}

The determination of has_git can be a bit fancier than a simple
!lstat() as you mentioned.
