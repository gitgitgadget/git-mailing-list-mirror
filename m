From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 15:36:13 +0530
Message-ID: <CAOLa=ZSOqHxpDRXMgANxqtMC5BzxBaK=uX3b7Yqxbu6ZNqokCQ@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
 <CAOLa=ZRZ6RcRm6ERR=NVzng17qJx+1N8iGThuo=xQhEszJQ90w@mail.gmail.com> <CAPig+cRUJa3hRk4utH6A8iHv6y2=XukTkiLWFet4dkeEw1sLzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWLzF-0005BT-8j
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbbHaKGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 06:06:45 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33958 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbHaKGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 06:06:45 -0400
Received: by obbfr1 with SMTP id fr1so89267535obb.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pDPdQtxoBOJwrKPy0fxha7Th0opTqYRjZigd6UzyXBM=;
        b=TtXj6YffeEvsSKAhNjs6cMPbS4iXrD0wJh5q1CeKgZSDKyqpzDmEICLX7dXxxgRtup
         pg0KoRY1t+apYF1RDH6VeSb181/F49DJDg/Pu8B0+VfmkB1AaLYm/NfuSHuTaBxFyLGr
         yMClVLl/8Zdd8x2QXrkwq9+fNRtviqKA3jyla8XglUWFIns1of9uEzhouB8/uYQVDRdV
         XIOXpO8ofLfqydVMzVC61ywcemeCeWv6AVGGPdosEqRQjxPMz8cQj6NW4B8ydMb2ydtq
         /mGtw8XsYJ30C41li2PL4uYg0L3eq68cs/dCIU72JAZwPCjDQK9LaWzSsNXW+XvnRbkW
         3w2w==
X-Received: by 10.60.92.199 with SMTP id co7mr7220259oeb.37.1441015602307;
 Mon, 31 Aug 2015 03:06:42 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 31 Aug 2015 03:06:13 -0700 (PDT)
In-Reply-To: <CAPig+cRUJa3hRk4utH6A8iHv6y2=XukTkiLWFet4dkeEw1sLzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276864>

On Mon, Aug 31, 2015 at 3:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 30, 2015 at 10:57 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> +struct align {
>>>> +       align_type position;
>>>> +       unsigned int width;
>>>>  };
>>>>
>>>>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
>>>> @@ -69,6 +79,8 @@ struct ref_formatting_state {
>>>>
>>>>  struct atom_value {
>>>>         const char *s;
>>>> +       struct align *align;
>>>
>>> Why does 'align' need to be heap-allocated rather than just being a
>>> direct member of 'atom_value'? Does 'align' need to exist beyond the
>>> lifetime of its 'atom_value'? If not, making it a direct member might
>>> simplify resource management (no need to free it).
>>
>> But it does, since we carry over the contents of align from atom_value to
>> cb_data of ref_formatting_stack and that holds the value until we read
>> the %(end)
>> atom hence it seemed like a better choice to allocate it on the heap
>
> So, you're saying that the 'atom_value' instance no longer exists at
> the point that processing of %(end) needs to access the alignment
> properties? If so, then heap allocation make sense. Thanks.

I was actually wrong there, if you see populate_value() the ref is
filled with atoms
which aren't really deallocated, hence the atom_value remains with the ref in
ref->value[atom]. where atom is obtained using parse_ref_filter_atom() hence it
makes sense to make it static. Thanks

-- 
Regards,
Karthik Nayak
