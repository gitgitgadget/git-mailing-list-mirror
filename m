From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Wed, 1 Jun 2016 19:23:18 -0700
Message-ID: <CAGZ79kbpdgtt89Wm=YL0f+-zMnEhoa3xvWtXxFFw38tX8GpsaQ@mail.gmail.com>
References: <20160601235233.21040-1-sbeller@google.com> <xmqq37owwhti.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 04:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8II8-0007xp-V3
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 04:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbcFBCXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 22:23:21 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36027 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcFBCXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 22:23:20 -0400
Received: by mail-qg0-f47.google.com with SMTP id q32so117590050qgq.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7k1aYHeReWYXzHXy6DrhM/BQHSNId7T97k6ZmSbbiwE=;
        b=XB7kgi3EcBoMhxfWnl+/pqsQSfswXFECZ0f4JLc5MCHZIBZyA+WSnoXW6Y67/DfwGf
         +8pfWlphvs6NntQ2VpIX3CGN8HxOogOkDc+9Z/ltBNbfELy5xJeMW5woQAsZa8I2rWfM
         q+D2h55EIqcKldBSJKpXnW9pAYcRu7zeEJ4BTgQEo2EtKa10JGR9BcsqIYR2f2kxyJ+w
         VyzuaEziF6Zc5uN2WlkFXY6q2uQfVuPn27KZMeJGL5NuK+vznEd0wTeWU7s1l+eguFQQ
         SkUrYUA42glQF+k0NPdVEIOj0xrVXiJ5HAZtXVv1nvp6FnK0vltjIYcYacd1/S415P0Q
         CC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7k1aYHeReWYXzHXy6DrhM/BQHSNId7T97k6ZmSbbiwE=;
        b=TU2F4kQjkSh1a+gslqHT+UfrTC6H0v8O5xDzxKe7ZZxR9Pxcrza4L4EB3CwUcsOKih
         8RX6VkIPK9IljhuN91mKlM+GDRYMSXup7MStG+odeaTDuKmpt3jzrhDgh6anpBWrdmjZ
         6/cPquVK5aIbjjmugHq9a8wCP28HPOCy7ntA0fQRIJ003f6BqwKN0BWLmEJv4imCJbQZ
         Kc6Q5IYmnNUo+o3/UJBMosMPGdV9jbkZx5P5BlOqxziC1zdS4ALsrZLK/ECDnuyRCTJl
         TS3hzqKEVpw5Omk9xzSBM/L7zcmJx/t2nYvTiG+xnkknYImIQzbJ+0BSDz/CuAOubOUl
         hzTA==
X-Gm-Message-State: ALyK8tL9KqpP7ZOCLRh9dpM5bsjixDxGp5pdMVJJYDBILh8okGxWMQy5Rsi4mMx4Rn6ZNu1ORXcRJS1xPDYAfOcR
X-Received: by 10.140.23.180 with SMTP id 49mr40021727qgp.9.1464834199060;
 Wed, 01 Jun 2016 19:23:19 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 19:23:18 -0700 (PDT)
In-Reply-To: <xmqq37owwhti.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296185>

On Wed, Jun 1, 2016 at 5:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This change allows escaping characters by a backslash, such that the query
>>
>>     git ls-files :(attr:whitespace=indent\,trail\,space)
>>
>> will match all path that have the value "indent,trail,space" for the
>> whitespace attribute. To accomplish this, we need to modify two places.
>> First `eat_long_magic` needs to not stop early upon seeing a comma or
>> closing paren that is escaped. As a second step we need to remove any
>> escaping from the attr value. For now we just remove any backslashes.
>>
>> Caveat: This doesn't allow for querying for values that have backslashes
>> in them, e.g.
>>
>>     git ls-files :(attr:backslashes=\\)
>>
>> that would ask for matches that have the `backslashes` value set to '\'.
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  * This applies on top of sb/pathspec-label
>>  * Junio does this come close to what you imagine for escaped commas?
>
> I, being lazy, would have used %44 for comma, which would have
> avoided touching higher level of the callchain.  But "a backslash
> always quotes the next byte, if you want to express a backslash,
> double it" would probably be a more end-user friendly quoting
> mechanism.

Heh, okay.

>
> I do not offhand understand why the second example does not show the
> paths with backslash attribute set to a single backslash, though.
>
>> -                             am->value = xstrdup(&attr[attr_len + 1]);
>> +                             am->value = attr_value_unquote(&attr[attr_len + 1]);
>>                               if (strchr(am->value, '\\'))
>>                                       die(_("attr spec values must not contain backslashes"));
>
> IOW, the "backslash is forbidden for now" IIUC was added there so
> that we can introduce a quoting like this--once we decided that
> quoting mechanism is via backslashes and have quoting support,
> shouldn't the "values must not have backslash" just go?

Right this can go now.

>
>>            *copyfrom && *copyfrom != ')';
>>            copyfrom = nextat) {
>>               size_t len = strcspn(copyfrom, ",)");
>> +             while (len > 0 && copyfrom[len - 1] == '\\'
>> +                    && (copyfrom[len] == ',' || copyfrom[len] == ')'))
>> +                     len += strcspn(copyfrom + len + 1, ",)") + 1;
>
> Good that we can use ')' in values, too, but I think this gets this
> case wrong:
>
>         :(attr:foo=\\,icase)
>
> where the value for 'foo' wants to be a single backslash, and comma
> is to introduce another magic, not part of the value for 'foo'.

Right, with this patch this would be interpreted as

    foo equal to ',icase'

>
> If you want to do the "backslash unconditionally quotes the next
> byte no matter what is quoted", you'd need to lose the strcspn()
> and iterate over the string yourself, I would think.

Okay, will do that instead.

>
>>               if (copyfrom[len] == ',')
>>                       nextat = copyfrom + len + 1;
>>               else
