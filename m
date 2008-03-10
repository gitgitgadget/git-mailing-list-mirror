From: David Brownell <david-b@pacbell.net>
Subject: Re: warning: no common commits - slow pull
Date: Mon, 10 Mar 2008 09:18:09 -0800
Message-ID: <200803101018.09282.david-b@pacbell.net>
References: <200803061735.47674.david-b@pacbell.net> <alpine.LNX.1.00.0803081826080.19665@iabervon.org> <alpine.LNX.1.00.0803091443440.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYleI-0004Ge-N4
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 18:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbYCJRSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 13:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYCJRSN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 13:18:13 -0400
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:44808 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751132AbYCJRSM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 13:18:12 -0400
Received: (qmail 9097 invoked from network); 10 Mar 2008 17:18:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=F0aHyQd1AVhq/cxvqOvR9QUlea7AZltmUiiUOdiPBP4nsTGK6bFUii5dpEgkkeupqf3TNAo7BpP92tCtbodKispWnEfh+SELrO7sIgIWw7djT57HwOvsfuNnp+FySBkMIumdJzssCO4cft7yI+AKOnTqyycgyVxYG6PcMl6lOkw=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.243.232 with plain)
  by smtp120.sbc.mail.sp1.yahoo.com with SMTP; 10 Mar 2008 17:18:10 -0000
X-YMail-OSG: duwefEQVM1mQsr315ugNwCs8IcCk9Zw7eJADJAGHkRBU2jbll8lEyJCrN7NnNauePB6Ika6_1wrrQNnXOujDJkVwxyLN.S0wWGuXW9f39xTd8XEkp2aqW7Vlf6zv
X-Yahoo-Newman-Property: ymail-3
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LNX.1.00.0803091443440.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76740>

On Sunday 09 March 2008, Daniel Barkalow wrote:
> Try this. I'm not at all sure that it's doing what I want, but it passes 
> all the current tests, and it should only affect your test case if it's 
> actually right.

Seems to resolve that problem for me ... well timed, in terms of RC5!

But some stuff still looks a bit fishy.  See this RC4 --> RC5 pull:

  remote: Counting objects: 1329, done.
  remote: Compressing objects: 100% (276/276), done.
  remote: Total 908 (delta 749), reused 760 (delta 631)
  Receiving objects: 100% (908/908), 146.35 KiB | 40 KiB/s, done.
  Resolving deltas: 100% (749/749), completed with 287 local objects.
  remote: Counting objects: 1330, done.
  remote: Compressing objects: 100% (277/277), done.
  remote: Total 909 (delta 749), reused 760 (delta 631)
  Receiving objects: 100% (909/909), 146.63 KiB | 38 KiB/s, done.
  Resolving deltas: 100% (749/749), completed with 287 local objects.
  From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
   * [new tag]         v2.6.25-rc5 -> v2.6.25-rc5
  Updating 29e8c3c..cdeeeae
  Fast forward
  Auto packing your repository for optimum performance. You may also
  run "git gc" manually. See "git help gc" for more information.
  ...

That's pretty typical:  two count/compress/receive/resolve passes,
with almost an identical shape and size.  Every time I see that, I
suspect that most of the second one should not be needed...

However, the grace of not re-fetching the entire GIT database (at
several hundred MBytes) the second time is much appreciated!

- Dave


> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -26,6 +26,8 @@ static const char fetch_pack_usage[] =
>  #define SEEN		(1U << 3)
>  #define POPPED		(1U << 4)
>  
> +static int marked;
> +
>  /*
>   * After sending this many "have"s if we do not get any new ACK , we
>   * give up traversing our history.
> @@ -61,6 +63,16 @@ static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int
>  	return 0;
>  }
>  
> +static int clear_marks(const char *path, const unsigned char *sha1, int flag, void *cb_data)
> +{
> +	struct object *o = deref_tag(parse_object(sha1), path, 0);
> +
> +	if (o && o->type == OBJ_COMMIT)
> +		clear_commit_marks((struct commit *)o, 
> +				   COMMON | COMMON_REF | SEEN | POPPED);
> +	return 0;
> +}
> +
>  /*
>     This function marks a rev and its ancestors as common.
>     In some cases, it is desirable to mark only the ancestors (for example
> @@ -153,6 +165,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
>  	unsigned in_vain = 0;
>  	int got_continue = 0;
>  
> +	if (marked)
> +		for_each_ref(clear_marks, NULL);
> +	marked = 1;
> +
>  	for_each_ref(rev_list_insert_ref, NULL);
>  
>  	fetching = 0;
> 
